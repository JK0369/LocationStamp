//
//  Collection.swift
//  
//
//  Created by KaungSoe on 4/7/18.
//  Copyright © 2018 Codigo. All rights reserved.
//

import UIKit

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
