//
//  SplashVC.swift
//  BaseProject
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import CommonExtension
import Domain
import RxSwift
import RxCocoa

final class SplashVC: BaseViewController, StoryboardInitializable, ErrorPresentable {
    static var storyboardName: String = Constants.Storyboard.splash
    static var storyboardID: String = SplashVC.className

    // MARK: - Property

    var viewModel: SplashVM!

    required init?(coder: NSCoder, viewModel: SplashVM) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - View Lifr Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        networkListener = .on
        setupErrorHandlerBinding()
    }

    private func setupInputBinding() {
        viewWillAppearEvent()
    }

    private func viewWillAppearEvent() {
        rx.viewWillAppear.asDriverOnErrorNever()
            .mapToVoid()
            .drive(onNext: { [weak self] in
                self?.viewModel.viewWillAppear()
            }).disposed(by: bag)
    }
}
