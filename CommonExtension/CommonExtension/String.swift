//
//  String.swift
//  ComfortDelGro
//
//  Created by Aung Htoo Myat Khaing on 8/20/18.
//  Copyright © 2018 Codigo. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

public enum DateFormat: String {
    
    /**
     yyyy-MM-dd'T'HH:mm:ss'Z'
     */
    case type1 = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    /**
     d-MM-yyyy HH:mm:ss
     */
    case type2 = "d-MM-yyyy HH:mm:ss"
    
    /**
     dd MMM yyyy
     */
    case type3 = "dd MMM yyyy"
    
    /**
     yyyy-MM-dd HH:mm:ss.SSS zzzxxx
     */
    case type4 = "yyyy-MM-dd HH:mm:ss.SSS zzzxxx"
    
    /**
     dd MMM yyyy, HH:mm
     */
    case type5 = "dd MMM yyyy, HH:mm"
    
    /**
     ddMMyyyyhhmmss
     */
    case type6 = "ddMMyyyyhhmmss"
    
    case type7 = "E d MMM yyyy, HH:mm"
    
    case type8 = "d MMM yyyy, HH:mm"
    
    case type9 = "dd/MM/yy"
    
    case type10 = "y-MM-dd"
    
    case type11 = "dd/MM/yyyy"
    
    case type12 = "dd/MM/yyyy HH:mm:ss"
    
    case type13 = "dd MMM yyyy - hh:mm:ss a"
    
    case type14 = "MM/yy"
    
    case type15 = "dd MMM yyyy - hh:mm:ss"

    case type16 = "MMM dd yyyy HH:mm:ss"
    
    case type17 = "hh:mma"
}

public extension String {
    
    static var empty = ""
    
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    var removedSpace: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
	
	var removedDot: String {
		return self.replacingOccurrences(of: ".", with: "")
	}
    
    var url: URL? {
        return URL(string: self)
    }
    
    var toInt: Int? {
        return Int(self)
    }
    
    var toDouble: Double? {
        return Double(self)
    }
    
    // https://stackoverflow.com/a/34423577/3378606
    func height(for width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return actualSize.height
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func toIntFlag() -> Int? {
        switch self {
        case "True", "true", "yes", "1":
            return 1
        case "False", "false", "no", "0":
            return 0
        default:
            return nil
        }
    }
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    // Helpers
    // Convert from 14:00(YGN) to 7:30(UTC)
    func convertToUTCTimestamp() -> String? {
        let strArr: [String] = self.components(separatedBy: ":")
        guard strArr.count > 1 else {
            return nil
        }
        
        let int0 = Int(strArr[0])
        let int1 = Int(strArr[1])
        let calendar = Calendar.current
        let today = Date()
        
        let com = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: today)
        
        var newcom = DateComponents()
        newcom.year = com.year
        newcom.month = com.month
        newcom.day = com.day
        newcom.hour = int0
        newcom.minute = int1
        let newcomdate = calendar.date(from: newcom)!
        
        let finalf = DateFormatter()
        finalf.dateFormat = "HH:mm"
        finalf.timeZone = TimeZone(abbreviation: "UTC")
        let finalfString = finalf.string(from: newcomdate)
        return finalfString
    }
    
    // Convert from 7:30(UTC) to 14:00(YGN)
    func convertFromUTCTimestamp() -> String? {
        let strArr: [String] = self.components(separatedBy: ":")
        guard strArr.count > 1 else {
            return nil
        }
        
        let int0 = Int(strArr[0])
        let int1 = Int(strArr[1])
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        let today = Date()
        let com = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: today)
        
        var newcom = DateComponents()
        newcom.year = com.year
        newcom.month = com.month
        newcom.day = com.day
        newcom.hour = int0
        newcom.minute = int1
        let newcomdate = calendar.date(from: newcom)!
        
        let finalf = DateFormatter()
        finalf.dateFormat = "HH:mm"
        return finalf.string(from: newcomdate)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func toDate(format: DateFormat, useBaseLang: Bool = false) -> Date? {
        
        let dateFormatter = DateFormatter()
        
        if useBaseLang {
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        }
        
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.date(from: self)
    }
    
    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func removeFirst() -> String? {
        return self.substring(from: 1, to: self.count)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: self) {
            return true
        }
        return false
    }
    
    func isValidTaxiNumber() -> Bool {
        
        // TST0728L
        // TST9993C
        // TST8888A
        
        let taxiNumberRegEx = "([A-Z]{2,3})([0-9]{1,4})([A-Z]{1})"
        let taxiNumberTest = NSPredicate(format: "SELF MATCHES %@", taxiNumberRegEx)
        if taxiNumberTest.evaluate(with: self) {
            return true
        }
        return false
    }
    
    func isImageURL() -> Bool {
        let imageFormats = ["jpg", "png", "gif", "jpeg"]
        
        if URL(string: self) != nil {
            let extensi = (self as NSString).pathExtension
            return imageFormats.contains(extensi)
        }
        return false
    }
    
    /**
     Getting Last 4
     */
    func last4() -> String {
        let maxCount = self.count
        if maxCount >= 4 {
            return self.substring(from: maxCount - 4, to: maxCount)
        } else {
            return ""
        }
    }
    
    /// if the string is "" return nil, otherwise actual value is returned
    var valueOrNil: String? {
        return self == "" ? nil : self
    }
    
    /*func md5() -> String {
        let messageData = self.data(using: .utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    } */
    
    func toDate(dateFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.date(from: self)
    }
    
    func add(character: String, byOffset offset: Int) -> String {
        
        var newString = ""
        
        for (index, char) in self.enumerated() {
            
            if index % offset == 0 && index != 0 {
                newString += "\(character)"
            }
            newString += "\(char)"
        }
        return newString
    }
    
    func removeAllSpaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

    func formatCardNumber() -> String {
        let spaceCardNumber = self.insertSpacesInCardNumber()
        return spaceCardNumber.insertSecureMarkInCardNumber()
    }

    private func insertSpacesInCardNumber() -> String {
        var ret = ""
        var pointer = 0

        for i in stride(from: 0, to: self.count, by: 1) {
            ret += self.substring(from: pointer, to: pointer)
            pointer += 1
            if i == 3 || i == 7 || i == 11 {
                ret += " "
            }
        }
        return ret
    }

    private func insertSecureMarkInCardNumber() -> String {
        var ret = ""

        for i in stride(from: 0, to: self.count, by: 1) {
            switch i {
            case 10, 11, 12, 13:
                ret += "*"
            default:
                ret += self.substring(from: i, to: i)
            }
        }
        return ret
    }

    func remove(startInd: Int, length: Int) -> String {
        return self.substring(from: 0, to: startInd - 1) + self.substring(from: startInd + length, to: self.count - 1)
    }

    func insertAt(_ position: Int, string: String) -> String {
        self.substring(from: 0, to: position - 1) + string + self.substring(from: position, to: self.count - 1)
    }

    func whiteSpaceCount(untilIndex: Int) -> Int {
        var ret = 0
        var ind = 0

        for value in self {
            if ind > untilIndex {
                break
            }

            if value == " " {
                ret += 1
            }

            ind += 1
        }

        return ret
    }
}
