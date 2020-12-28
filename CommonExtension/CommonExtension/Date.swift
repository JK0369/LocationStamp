//
//  Date.swift
//  ComfortDelGro
//
//  Created by Aung Htoo Myat Khaing on 8/20/18.
//  Copyright © 2018 Codigo. All rights reserved.
//

import Foundation

public enum DateComponentType {
    case day, month, year
}

public extension Date {
    
    func toYear(_ year: Int) -> Date {
        let currentYear = Calendar.current.component(.year, from: Date())
        guard year < currentYear else { return self }
        let difference = currentYear - year
        return Date().adjust(component: .year, offset: -difference)
    }
    
    func adjust(component: DateComponentType, offset: Int) -> Date {
        switch component {
        case .day:
            break
        case .month:
            break
        case .year:
            return Calendar.current.date(byAdding: .year, value: offset, to: self, wrappingComponents: true) ?? self
        }
        
        return self
    }
    
    // Date Custom Formatting
    func toStringWith(_ format: DateFormat, _ calendarIdentifier: Calendar.Identifier = .gregorian) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: calendarIdentifier)
        dateFormatter.dateFormat = format.rawValue
        let strDate = dateFormatter.string(from: self)
        return strDate
    }
    
    func add(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    // https://stackoverflow.com/questions/44086555/swift-time-ago-from-parse-createdat-date
    func timeAgoDisplay() -> String {
        
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        
        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "\(diff) seconds ago"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff) mins ago"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) hours ago"
        } else {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            if diff < 6 {
                return "\(diff) day ago"
            } else {
                return self.toStringWith(.type3)
            }
        }
    }
    
    var nextDay: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self, wrappingComponents: true) ?? self
    }
    
    func toString(currentFormat: String = "dd-MM-yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = currentFormat
        return formatter.string(from: self)
    }
    
    func changeFormatAndMakeString(fromFormat: String, toFormat: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat
        if let date = formatter.date(from: self.toString(currentFormat: fromFormat)) {
            formatter.dateFormat = toFormat
            return formatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func formatToString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Int64 { // unix time
    public func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self) / 1000)
    }
}
