//
//  Constant.swift
//
//  Created by shishir on 06/10/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import Foundation
import UIKit

typealias ResponseBlock = (_ responder : Any?, _ error : CarouselError?) -> Void
typealias ActionBlock = (_ responder : Any?) -> Void
typealias ResultBlock = (Result) -> Void

enum KeyPad {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case zero
    case delete
    case next
    
    var string : String? {
        let string : String?
        switch self {
        case .delete:
            string = nil
        case .one :
            string = "1"
        case .two :
            string = "2"
        case .three :
            string = "3"
        case .four :
            string = "4"
        case .five :
            string = "5"
        case .six :
            string = "6"
        case .seven :
            string = "7"
        case .eight :
            string = "8"
        case .nine :
            string = "9"
        case .zero :
            string = "0"
        case .next :
            string = nil
        }
        return string
    }
}

enum Type {
    case a
    case b
    case c
    
    var placeholder : String {
        let string : String
        switch self {
        case .a :
            string = "00"
        case .b :
            string = "00"
        case .c :
            string = "00"
        }
        return string
    }
    
    var prefix : String {
        let string : String
        switch self {
        case .a:
            string = "A"
        case .b:
            string = "B"
        case .c:
            string = "C"
        }
        return string
    }
    
    var description : String {
        let string : String
        switch self {
        case .a:
            string = "A description"
        case .b:
            string = "B description"
        case .c:
            string = "C description"
        }
        return string
    }
    
    var minVal : Int {
        let val : Int
        switch self {
        case .a:
            val = 30
        case .b:
            val = 30
        case .c:
            val = 30
        }
        return val
    }
    
    var maxVal : Int {
        let val : Int
        switch self {
        case .a:
            val = 300
        case .b:
            val = 300
        case .c:
            val = 300
        }
        return val
    }
}

enum ViewType {
    case keypad
    case entryView
}

enum CarouselError: Error {
    case unknown
    case failedRequest
    case invalidResponse
    case realmError
    case noResult
}

enum Result{
    case success
    case failure(String)
}

enum ViewState {
    case loading
    case loaded
    case stop
    case error(String)
}

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}

extension UIView {
    public class var identifier : String {
        var name = NSStringFromClass(self)
        name = name.components(separatedBy: ".").last!
        return name
    }
}
