//
//  DataSourceModel.swift
//
//  Created by shishir on 06/10/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import UIKit

class DataSourceModel <T> {
    
    var result : [T]?
    
    init(result : [T]) {
        self.result = result
    }
}

extension DataSourceModel : DataSourceProtocol {
    
    func viewModel(numberOfItemsInSection: Int) -> Int {
        return result?.count ?? 0
    }
    
    func viewModel(modelAt indexPath: IndexPath) -> Any? {
        return result?[safe:indexPath.row]
    }
    
}
