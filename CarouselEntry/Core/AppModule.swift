//
//  AppModule.swift
//
//  Created by shishir on 11/11/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import Foundation

class AppModule {
    static let shared = AppModule()
    
    func getDocumentsDirectory() -> URL? {
        var url:URL? = nil
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if let path = paths.first {
            url = path
        }
        return url
    }
    
    func getLocalPath() -> URL? {
        var url:URL? = nil
        if let path = getDocumentsDirectory() {
            url = path.appendingPathComponent("coxvoice.mp4")
        }
        return url
    }
    
    func getTextFilePath() -> String?  {
        return getLocalPath()?.absoluteString

    }
}
