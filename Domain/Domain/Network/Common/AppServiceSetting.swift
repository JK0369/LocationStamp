//
//  AppServiceSetting.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation

public struct AppServiceConfigurations {
    public let useStub = false
    public var serviceBaseURL: URL!
    public var mapStyleURL: URL!
    public var appInfoHeader: AppInfoHeader?
    public var bearerToken: String?
}

public protocol AppServiceConfigurable {
    func setBaseURL(_ url: URL)
    func setMapStyleBaseURL(_ url: URL)
    func setToken(_ token: String)
    func setAppInfoHeader(_ appInfoHeader: AppInfoHeader)
}

public class AppServiceSetting: AppServiceConfigurable {
    public static let shared = AppServiceSetting()
    public var configurations = AppServiceConfigurations()
    private init() {}

    public func setBaseURL(_ url: URL) {
        configurations.serviceBaseURL = url
    }

    public func setMapStyleBaseURL(_ url: URL) {
        configurations.mapStyleURL = url
    }

    public func setToken(_ token: String) {
        configurations.bearerToken = token
    }

    public func setAppInfoHeader(_ appInfoHeader: AppInfoHeader) {
        configurations.appInfoHeader = appInfoHeader
    }
}
