//
//  UserDefault.swift
//  CommonExtension
//
//  Created by Codigo Kaung Soe on 13/05/2020.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    public static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }

}
