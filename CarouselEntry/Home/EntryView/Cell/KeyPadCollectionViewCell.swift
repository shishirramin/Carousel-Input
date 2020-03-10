//
//  KeyPadCollectionViewCell.swift
//
//  Created by shishir on 06/10/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import UIKit

class KeyPadCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    var viewModel : KeyPadDataViewModel? = nil
    var size = CGSize.zero
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var widthConstant: NSLayoutConstraint!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    
    override func awakeFromNib() {
        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        let constant = min(size.width, size.height)
        bgView?.layer.cornerRadius = constant/2
        widthConstant.constant = constant
        heightConstant.constant = constant
    }
    
    func configure() {
        bgView?.layer.borderWidth  = 2
        bgView?.layer.borderColor = #colorLiteral(red: 0.4509803922, green: 0.4509803922, blue: 0.4509803922, alpha: 1)
        numberLabel?.text = viewModel?.title
    }
}
