//
//  UIWindow.swift
//  Isetan
//
//  Created by Kaung Soe on 3/28/19.
//

import UIKit

public extension UIWindow {
    
    func replaceRootVC(with vc: UIViewController, duration: TimeInterval = 0.4, options: UIView.AnimationOptions = .transitionCrossDissolve) {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController = vc
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
    }
    
    var safeArea: (top: CGFloat, bottom: CGFloat) {
        if #available(iOS 11.0, *) {
            let windo = UIApplication.shared.delegate?.window
            return (top: windo??.safeAreaInsets.top ?? 20, bottom: windo??.safeAreaInsets.bottom ?? 0)
        }
        return (top: 20, bottom: 0)
    }
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
