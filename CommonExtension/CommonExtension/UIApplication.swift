//
//  UIApplication.swift
//  Isetan
//
//  Created by Kaung Soe on 4/18/19.
//  Copyright © 2019 codigo. All rights reserved.
//

import UIKit

public extension UIApplication {
	
	var appVersion: String {
		let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
		return appVersion.replacingOccurrences(of: ".", with: "")
	}
	
	var appVersionWithoutDot: String {
		return appVersion.replacingOccurrences(of: ".", with: "")
	}
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
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
