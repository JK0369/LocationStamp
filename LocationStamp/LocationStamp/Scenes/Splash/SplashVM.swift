//
//  SplashVM.swift
//  BaseProject
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import CommonExtension
import Domain
import RxSwift
import RxCocoa

class SplashVM: ErrorHandleable {

    struct Dependencies {
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Output

    var showError = PublishRelay<ErrorData>()

    // MARK: - Properties

    let dependencies: Dependencies
    let bag = DisposeBag()

    // MARK: - Handling View Input

    func viewWillAppear() {
        
    }
}
