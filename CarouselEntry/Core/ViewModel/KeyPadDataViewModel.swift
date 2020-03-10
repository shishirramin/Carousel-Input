//
//  KeyPadDataViewModel.swift
//
//  Created by shishir on 06/10/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import Foundation

class KeyPadDataViewModel {
    let keyPad : KeyPad
    
    init(keyPad:KeyPad) {
        self.keyPad = keyPad
    }
    
    var title : String? {
        return keyPad.string
    }
}
