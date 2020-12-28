//
//  UITextField.swift
//  TapRider
//
//  Created by 김종권 on 2020/12/23.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation
import UIKit
import AnyFormatKit

extension UITextField {
    func formatPhoneNumber(range: NSRange, string: String) {
        guard let text = self.text else {
            return
        }
        let characterSet = CharacterSet(charactersIn: string)
        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
            return
        }

        let newLength = text.count + string.count - range.length
        let formatter: DefaultTextInputFormatter
        let onlyPhoneNumber = text.filter { $0.isNumber }

        let currentText: String
        if newLength < 13 {
            if text.count == 13, string.isEmpty { // crash 방지
                formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
            } else {
                formatter = DefaultTextInputFormatter(textPattern: "###-###-####")
            }
        } else {
            formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
        }

        currentText = formatter.format(onlyPhoneNumber) ?? ""
        let result = formatter.formatInput(currentText: currentText, range: range, replacementString: string)
        if text.count == 13, string.isEmpty {
            self.text = DefaultTextInputFormatter(textPattern: "###-###-####").format(result.formattedText.filter { $0.isNumber })
        } else {
            self.text = result.formattedText
        }

        let position: UITextPosition
        if self.text?.substring(from: result.caretBeginOffset - 1, to: result.caretBeginOffset - 1) == "-" {
            position = self.position(from: self.beginningOfDocument, offset: result.caretBeginOffset + 1)!
        } else {
            position = self.position(from: self.beginningOfDocument, offset: result.caretBeginOffset)!
        }

        self.selectedTextRange = self.textRange(from: position, to: position)
    }
}
