//
//  Formatter.swift
//  Isetan
//
//  Created by Nay Oo Linn on 4/26/19.
//  Copyright © 2019 codigo. All rights reserved.
//

import Foundation

public extension Formatter {
    static let withComma: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}
