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
import XCoordinator

class SplashVM: ErrorHandleable {

    struct Dependencies {
        let router: UnownedRouter<SplashRoute>
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.routeToPhoto()
        }
    }

    private func routeToPhoto() {
        dependencies.router.trigger(.popAndPush(.photo))
    }
}
