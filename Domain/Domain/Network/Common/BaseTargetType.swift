//
//  BaseTargetType.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import Moya

public protocol BaseTargetType: TargetType { }
extension BaseTargetType {

    public var sampleData: Data {
        return Data()
    }

    public var headers: [String: String]? {
        let header = ["Content-Type": "application/json"]
        return header
    }
}
