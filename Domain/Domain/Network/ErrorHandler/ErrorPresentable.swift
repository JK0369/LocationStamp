//
//  ErrorPresentable.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import CommonExtension
import RxSwift
import RxCocoa

public protocol ErrorPresentable: BaseViewController {
    associatedtype ViewModel: ErrorHandleable
    var viewModel: ViewModel! { get }

    func setupErrorHandlerBinding()
}

public extension ErrorPresentable {
    func setupErrorHandlerBinding() {
        viewModel.showError.asDriverOnErrorNever()
            .drive(rx.showErrorMessageDialog) // 커스텀 dialog는 다른 글 참고
            .disposed(by: bag)
    }
}
