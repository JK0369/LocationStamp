//
//  NSObject.swift
//  ComfortDelGro
//
//  Created by Aung Htoo Myat Khaing on 8/24/18.
//  Copyright © 2018 Codigo. All rights reserved.
//

import Foundation

public extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
