//
//  DataViewModel.swift
//
//  Created by shishir on 06/10/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import Foundation

class DataViewModel {
   
    var vital : Vitals? = nil
    var responseBlock : ResponseBlock? = nil
    
    init(vital:Vitals) {
        self.vital = vital
    }
    
    var textValue : String? {
        return vital?.value ?? vital?.type.placeholder
    }
    
    var isEmpty : Bool {
        return vital?.value == nil
    }
    
    var intValue : Int {
        return Int(vital?.value ?? "0") ?? 0
    }
    
    var minIntValue : Int {
        return vital?.type.minVal ?? 0
    }
    
    var maxIntValue : Int {
        return vital?.type.maxVal ?? 0
    }
    
    var descriptionString : String? {
        return vital?.type.description ?? ""
    }
    
    var vitalValue : String? {
        return vital?.value
    }
}
