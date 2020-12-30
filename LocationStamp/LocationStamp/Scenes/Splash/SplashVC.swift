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
import Moya

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

    // MARK: - View Lifr Cyclehvc

    override func viewDidLoad() {
        super.viewDidLoad()
        networkListener = .on
        setupErrorHandlerBinding()
        setupInputBinding()
        let usecase = MoyaProvider<ReverseGeoCodingTarget>.makeProvider()
        let request = ReverseGeoCodingRequest(latitude: 37.325130462646484, longitude: 127.1183853149414)
        usecase.rx.request(.reverseGeoCoding(request))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (result) in
                switch result {
                case .success(let response):
                    print(response)
                case .error(let error):
                    print(error)
                }
            }.disposed(by: bag)
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
