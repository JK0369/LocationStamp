//
//  Date.swift
//  TapRider
//
//  Created by Codigo Sheilar on 14/05/2020.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation

extension Date {
    
    static func getOperationTime(start: Date, end: Date) -> String {
        let startValue = start.to24HourMinute()
        let endValue = end.to24HourMinute()
        
        return "\(startValue) - \(endValue)"
    }
    
    func to12HourMinute() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "오전"
        formatter.pmSymbol = "오후"
        return formatter.string(from: self)
    }
    
    func to24HourMinute() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        return "\(hour):\(minute)"
    }
    
    func toYearMonth() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        return "\(year)년 \(month)월"
    }
    
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
