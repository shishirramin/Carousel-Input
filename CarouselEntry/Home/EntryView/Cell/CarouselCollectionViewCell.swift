//
//  CarouselCollectionViewCell.swift
//
//  Created by shishir on 07/10/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    var viewModel : DataViewModel? = nil
    
    func configure() {
        descriptionLabel.text = viewModel?.descriptionString
        valueLabel.text = viewModel?.textValue
    }
}
