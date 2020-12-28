//
//  BaseServiceError.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import Moya

public enum BaseServiceError: Error {
    case moyaError(MoyaError)
    case invalidResponse(responseCode: Int, message: String) // response code가 0이 아닌경우
}

extension BaseServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .moyaError(let moyaError):
            return moyaError.localizedDescription
        case let .invalidResponse(responseCode, messase):
            return "\(messase)(\(responseCode))"
        }
    }
}
