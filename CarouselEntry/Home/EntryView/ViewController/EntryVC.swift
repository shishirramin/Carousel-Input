//
//  EntryVC.swift
//
//  Created by shishir on 06/10/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import UIKit

class EntryVC: UIViewController {
    
    @IBOutlet weak var keyPadCollectionView: UICollectionView!
    @IBOutlet weak var carasouelCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    lazy var entryViewModel = EntryViewModel()
    var size = CGSize.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)

        let viewHeight = (UIScreen.main.bounds.size.height*175)/(675-49)
        let actualHeight = UIScreen.main.bounds.size.height-viewHeight-49
        let width = (view.frame.size.width-60-20)/3
        let height = (actualHeight-40-30)/4
        size = CGSize(width: width, height: height)
        
        //
        let floawLayout = CarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 40 - 40)/3, height: carasouelCollectionView.frame.size.height)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.7
        floawLayout.sideItemAlpha = 0.5
        floawLayout.spacingMode = .fixed(spacing: 20.0)
        carasouelCollectionView.collectionViewLayout = floawLayout
        
        refresh()
    }
    
    func refresh()  {
        carasouelCollectionView.scrollToItem(at: IndexPath(row: entryViewModel.getSelectedType(), section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        carasouelCollectionView.reloadData()
        pageControl.currentPage = entryViewModel.getSelectedType()
    }
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            entryViewModel.seclectDataForSection(section: currentPage)
            pageControl.currentPage = entryViewModel.getSelectedType()
        }
    }
    
    @IBAction func didTapOnPageControl(_ sender: Any) {
        
    }
    
}

extension EntryVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == keyPadCollectionView {
            entryViewModel.viewType = .keypad
        } else {
            entryViewModel.viewType = .entryView
            
        }
        return entryViewModel.viewModel(numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == keyPadCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyPadCollectionViewCell.identifier, for: indexPath) as? KeyPadCollectionViewCell
            entryViewModel.viewType = .keypad
            cell?.viewModel = entryViewModel.viewModel(modelAt: indexPath) as? KeyPadDataViewModel
            cell?.configure()
            cell?.size = size
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as? CarouselCollectionViewCell
            entryViewModel.viewType = .entryView
            cell?.viewModel = entryViewModel.viewModel(modelAt: indexPath) as? DataViewModel
            cell?.configure()
            return cell!
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == keyPadCollectionView {
            return
        }
        let layout = self.carasouelCollectionView.collectionViewLayout as! CarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.carasouelCollectionView.collectionViewLayout as! CarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
}

extension EntryVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == keyPadCollectionView {
            entryViewModel.viewType = .keypad
            let viewModel = entryViewModel.viewModel(modelAt: indexPath) as? KeyPadDataViewModel
            if viewModel?.keyPad == .next {
                
            } else {
                entryViewModel.refresh(modelAt: indexPath)
                refresh()
            }
            
        }
    }
}

extension EntryVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
    }
}
