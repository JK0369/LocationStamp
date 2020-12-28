//
//  UILabel.swift
//  CommonExtension
//
//  Created by Byeongjo Bae on 2020/10/14.
//  Copyright © 2020 42dot. All rights reserved.
//

import UIKit

extension UILabel {
    public func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment

        let attrString = NSMutableAttributedString()
        if let attributedText = self.attributedText {
            attrString.append(attributedText)
        } else if let text = self.text {
            attrString.append(NSMutableAttributedString(string: text))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        self.attributedText = attrString
    }
}
