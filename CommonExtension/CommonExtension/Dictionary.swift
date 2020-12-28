//
//  Dictionary.swift
//  CommonExtension
//
//  Created by Codigo Kaung Soe on 21/01/2020.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation

public extension Dictionary {
    mutating func swap(key1: Key, key2: Key) {
        if  let value = self[key1], let existingValue = self[key2] {
            self[key1] = existingValue
            self[key2] = value
        }
    }
}
