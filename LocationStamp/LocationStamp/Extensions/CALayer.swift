//
//  CALayer.swift
//  TapRider
//
//  Created by Sheilar Zune on 4/20/20.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func applySketchShadow(color: UIColor = .black,
                           alpha: Float,
                           xPoint: CGFloat,
                           yPoint: CGFloat,
                           blur: CGFloat,
                           spread: CGFloat) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: xPoint, height: yPoint)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let diffx = -spread
            let rect = bounds.insetBy(dx: diffx, dy: diffx)
            self.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
