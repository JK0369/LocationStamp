//
//  UITextField.swift
//  Isetan
//
//  Created by Nay Oo Linn on 5/2/19.
//  Copyright © 2019 codigo. All rights reserved.
//

import UIKit

public extension UITextField {
    
    enum TextFieldType {
        case CreditCard_No
        case CreditCard_EXPIREDATE
        case CreditCard_CVC
    }
    
    enum TextFieldMaxChar: Int {
        case CreditCard_No = 18
        case CreditCard_EXPIREDATE = 4
        case CreditCard_CVC = 3
    }
    
    func limitTextTo(max count: Int, range: NSRange, string: String) -> Bool {
        let currentText = text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= count

    }
    
    func shouldChangeCharacters(type: TextFieldType, range: NSRange, string: String) -> Bool {
        
        let char = string.cString(using: String.Encoding.utf8)!
        var isBackSpace = false
        if strcmp(char, "\\b") == -92 {
            isBackSpace = true
        }
        var originalText = self.text
        switch type {
        case .CreditCard_No:
            if range.location > 0 && !isBackSpace {
                if range.location == 4 || range.location == 9 || range.location == 14 {
                    originalText?.append(" ")
                    self.text = originalText
                    return true
                }
                if range.location > TextFieldMaxChar.CreditCard_No.rawValue {
                    return false
                }
            }        
        case .CreditCard_EXPIREDATE:
            if range.location == 2  && !isBackSpace {
                originalText?.append("/")
                self.text = originalText
                return true
            }
            
            if range.location > TextFieldMaxChar.CreditCard_EXPIREDATE.rawValue {
                return false
            }

        case .CreditCard_CVC:
            if range.location < TextFieldMaxChar.CreditCard_CVC.rawValue {
                return true
            } else {
                return false
            }
        }
        return true
    }
}
