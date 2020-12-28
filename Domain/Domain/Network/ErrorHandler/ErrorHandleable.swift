//
//  ErrorHandleable.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import RxSwift
import RxCocoa

public struct ErrorData {
    public let title: String?
    public let message: String

    public init(title: String? = nil, message: String) {
        self.title = title
        self.message = message
    }
}

public protocol ErrorHandleable {
    var showError: PublishRelay<ErrorData> { get }

    func handleError(_ error: Error)
}

public extension ErrorHandleable {
    func handleError(_ error: Error) {
        let data: ErrorData
        if case .invalidResponse = error as? BaseServiceError {
            data = ErrorData(title: "서버 에러", message: error.localizedDescription)
        } else {
            data = ErrorData(title: "에러", message: error.localizedDescription)
        }
        showError.accept(data)
    }
}
