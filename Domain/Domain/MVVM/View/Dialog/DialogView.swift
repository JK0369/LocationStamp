//
//  DialogView.swift
//  AlertExample
//
//  Created by 김종권 on 2020/11/28.
//

import Foundation
import UIKit

class DialogView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 0
        applySketchShadow(alpha: 0.3, xPoint: 0, yPoint: 24, blur: 24, spread: 0)
    }
}

extension UIView {
    public func applySketchShadow(color: UIColor = .black,
                           alpha: Float,
                           xPoint: CGFloat,
                           yPoint: CGFloat,
                           blur: CGFloat,
                           spread: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: xPoint, height: yPoint)
        layer.shadowRadius = blur / 2.0
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let diffx = -spread
            let rect = layer.bounds.insetBy(dx: diffx, dy: diffx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
