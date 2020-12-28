//
//  AppInfoHeader.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import UIKit

public struct AppInfoHeader {
    public let appDeviceUUID: String
    public let appDeviceModelName: String
    public let appDeviceOSVersion: String
    public let appDeviceDeviceManufacturer: String
    public let appVersion: String

    public init(
        appDeviceUUID: String,
        appDeviceModelName: String,
        appDeviceOSVersion: String,
        appDeviceDeviceManufacturer: String,
        appVersion: String
    ) {
        self.appDeviceUUID = appDeviceUUID
        self.appDeviceModelName = appDeviceModelName
        self.appDeviceOSVersion = appDeviceOSVersion
        self.appDeviceDeviceManufacturer = appDeviceDeviceManufacturer
        self.appVersion = appVersion
    }
}

extension AppInfoHeader {
    public static func appInfoHeader(with uuid: String) -> AppInfoHeader {
        return AppInfoHeader(
            appDeviceUUID: uuid,
            appDeviceModelName: UIDevice.current.name,
            appDeviceOSVersion: UIDevice.current.systemVersion,
            appDeviceDeviceManufacturer: "apple",
            appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        )
    }
}
