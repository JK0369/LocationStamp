//
//  Int.swift
//  ComfortDelGro
//
//  Created by Aung Htoo Myat Khaing on 9/12/18.
//  Copyright © 2018 Codigo. All rights reserved.
//

import Foundation

public extension Int {
    
    var pred: Int {
        self - 1
    }
    
    var succ: Int {
        self + 1
    }
    
    var isEven: Bool {
        return self % 2 == 0
    }
    
    func secondToFormattedHour() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        
        if hours > 0 {
            return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
    
	func secondToHour() -> (h: String?, m: String, s: String) {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        
        if hours > 0 {
            let value = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
                .split(separator: ":").compactMap { "\($0)" }
            return (value[0], value[1], value[2])
        } else {
            let value = String(format: "%02i:%02i", minutes, seconds).split(separator: ":").compactMap { "\($0)" }
            return (nil, value[0], value[1])
        }
    }
    
    
    func commaFormattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
    func toCurrency(with symbol: String = "") -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self))
    }
}

public extension Double {
    
    func toCurrency(withPrefix symbol: String = "") -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self))
    }
    
}
