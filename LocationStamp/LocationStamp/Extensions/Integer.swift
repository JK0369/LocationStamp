//
//  Integer.swift
//  TapRider
//
//  Created by Codigo Phyo Thiha on 4/11/20.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation
extension Int {
    func secondsToHoursMinutesSeconds () -> String {
        let minute = (self % 3600) / 60
        let seconds = (self % 3600) % 60
        if minute == 0 {
           return "\(seconds)초 후 재전송 가능"
        }
        return "\(minute)분 \(seconds)초 후 재전송 가능"
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
