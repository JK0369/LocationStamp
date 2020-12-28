//
//  Bundle.swift
//  CommonExtension
//
//  Created by Byeongjo Bae on 2020/07/31.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation

extension Bundle {
    public var appVersion: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
