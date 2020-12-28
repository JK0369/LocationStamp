//
//  ServiceConfiguration.swift
//  BaseProject
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation

class ServiceConfiguration {
    enum DeployType: String {
        case debug
        case alpha
        case release
    }

    private static let configKey = "DeployPhase"

    static func getDeployPhase() -> DeployType {
        // info.plist -> key: DeployPhase, value: $(DEPLOY_PHASE)
        let configValue = Bundle.main.object(forInfoDictionaryKey: configKey) as! String
        guard let phase = DeployType(rawValue: configValue) else {
            // TODO 로그레벨 warning 적용!!
            print("Something wrong in project configurations fot Deployment Phase! Check User Defined Settings.")
            return DeployType.release
        }
        return phase
    }

    public static func serviceBaseURL() -> URL {
        switch getDeployPhase() {
        case .debug, .alpha:
            return URL(string: "base/")!
        case .release:
            return URL(string: "release/")!
        }
    }

    public static func mapStyleBaseURL() -> URL {
        switch getDeployPhase() {
        case .debug, .alpha:
            return URL(string: "base/")!
        case .release:
            return URL(string: "release/")!
        }
    }
}
