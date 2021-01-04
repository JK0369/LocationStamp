//
//  UIButton.swift
//  TapRider
//
//  Created by Codigo Sheilar on 08/05/2020.
//  Copyright © 2020 42dot. All rights reserved.
//

import UIKit
import CommonExtension

extension UIButton {
    func setImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        kf.setImage(with: url, for: .normal)
    }

    func animateStroke(_ storkeLayer: CAShapeLayer) {
        
        storkeLayer.fillColor = UIColor.clear.cgColor
        storkeLayer.strokeColor = UIColor.blue.cgColor
        storkeLayer.lineWidth = 3
        storkeLayer.path = CGPath.init(roundedRect: bounds, cornerWidth: 8, cornerHeight: 8, transform: nil)
        
        layer.addSublayer(storkeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.duration = 0.7
        animation.isRemovedOnCompletion = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        storkeLayer.add(animation, forKey: "circleAnimation")
    }

    func setFloatingStyle() {
        setShadow(color: .black, alpha: 0.2, xPoint: 0, yPoint: 6, blur: 10, spread: 0)
    }

    func setShadowRoundStyle() {
        self.layer.cornerRadius = self.bounds.height / 2
        self |> CommonExtension.applySketchShadow(color: .black, alpha: 0.12, xPoint: 0, yPoint: 1, blur: 6, spread: 0)
    }

    func setOutlineStyle(isSelect: Bool) {
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.textAlignment = .center

        if isSelect {
            setTitleColor(.blue, for: .normal)
            layer.borderWidth = 2.0
            layer.borderColor = UIColor.blue.cgColor
            layer.cornerRadius = 8.0
        } else {
            setTitleColor(.gray, for: .normal)
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.gray.cgColor
            layer.cornerRadius = 8.0
        }
    }

}
