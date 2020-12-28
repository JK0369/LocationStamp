//
//  UIView.swift
//  TapRider
//
//  Created by Codigo Sheilar on 28/05/2020.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation
import UIKit

public typealias SimpleClosure = (() -> Void)
private var tappableKey: UInt8 = 0
private var actionKey: UInt8 = 1

public extension UIView {
    
    func xibSetup() {
        guard let view = loadViewFromNib(nib: type(of: self).className) else {
            return
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = bounds
        addSubview(view)
        view.fillToSuperview()
    }

    @objc var viewOnClickListener: SimpleClosure {
        get {
            return objc_getAssociatedObject(self, &actionKey) as! SimpleClosure
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var gesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(tapped))
    }
    
    var tappable: Bool! {
        get {
            return objc_getAssociatedObject(self, &tappableKey) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tappableKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.addTapGesture()
        }
    }

    fileprivate func addTapGesture() {
        if self.tappable {
            self.gesture.numberOfTapsRequired = 1
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        }
    }

    @objc private func tapped() {
        viewOnClickListener()
    }

    func setShadow(color: UIColor = .black,
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
