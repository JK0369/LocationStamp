//
//  UIViewController.swift
//  TapRider
//
//  Created by Codigo Sheilar on 27/04/2020.
//  Copyright © 2020 42dot. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var bottomSafeArea: CGFloat {
        guard let bottom = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.safeAreaInsets.bottom else {
            return 0
        }
        
        return bottom
    }
    
    var hasNotch: Bool {
           if #available(iOS 11.0, *) {
            return UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom ?? 0 > 0
           }
           return false
      }
    

}
