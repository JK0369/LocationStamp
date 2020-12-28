//
//  Number.swift
//  Isetan
//
//  Created by Nay Oo Linn on 5/7/19.
//  Copyright © 2019 codigo. All rights reserved.
//

import Foundation

public extension FloatingPoint {
    var isInteger: Bool {
        return rounded() == self
    }
}
