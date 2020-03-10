//
//  Array+App.swift
//
//  Created by shishir on 03/11/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
