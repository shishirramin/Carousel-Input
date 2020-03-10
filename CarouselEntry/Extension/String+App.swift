//
//  String+App.swift
//
//  Created by shishir on 03/11/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import Foundation

extension String {
    func localizeString(comment:String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
