//
//  String.swift
//  TapRider
//
//  Created by Codigo Sheilar on 08/05/2020.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func width(font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: .zero, height: 16))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        return label.frame.width
    }

    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        let versionDelimiter = "."
        var versionComponents = self.components(separatedBy: versionDelimiter)
        var otherVersionComponents = otherVersion.components(separatedBy: versionDelimiter)
        let zeroDiff = versionComponents.count - otherVersionComponents.count

        if zeroDiff == 0 {
            // Same format, compare normally
            return self.compare(otherVersion, options: .numeric)
        } else {
            let zeros = Array(repeating: "0", count: abs(zeroDiff))
            if zeroDiff > 0 {
                otherVersionComponents.append(contentsOf: zeros)
            } else {
                versionComponents.append(contentsOf: zeros)
            }
            return versionComponents.joined(separator: versionDelimiter)
                .compare(otherVersionComponents.joined(separator: versionDelimiter), options: .numeric)
        }
    }
}
