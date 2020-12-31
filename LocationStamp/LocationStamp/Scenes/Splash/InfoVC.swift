//
//  InfoVC.swift
//  LocationStamp
//
//  Created by 김종권 on 2020/12/31.
//

import Foundation
import CommonExtension
import Domain
import RxSwift
import RxCocoa
import Moya

final class InfoVC: BaseViewController, StoryboardInitializable, ErrorPresentable {
    static var storyboardName: String = Constants.Storyboard.splash
    static var storyboardID: String = InfoVC.className

    // MARK: - Property

    @IBOutlet weak var btnConfirm: UIButton!
    var viewModel: InfoVM!

    required init?(coder: NSCoder, viewModel: InfoVM) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - View Lifr Cyclehvc

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputBinding()
        setupErrorHandlerBinding()
        setupOutputBinding()
    }

    private func setupInputBinding() {
        viewWillAppearEvent()

        btnConfirmTapEvent()
    }

    private func viewWillAppearEvent() {
        rx.viewWillAppear.asDriverOnErrorNever()
            .mapToVoid()
            .drive(onNext: { [weak self] in
                self?.viewModel.viewWillAppear()
            }).disposed(by: bag)
    }

    private func btnConfirmTapEvent() {
        btnConfirm.rx.tap.asDriverOnErrorNever()
            .drive(onNext: { [weak self] in
                self?.viewModel.didTapBtnConfrim()
            }).disposed(by: bag)
    }

    // MARK: - OutputBinding

    private func setupOutputBinding() {
        viewModel.requireLocationAuth.asDriverOnErrorNever()
            .drive(onNext: { [weak self] in
                self?.showAlertAndSetting(alertTitle: "현재 위치를 확인하기 위해 위치 서비스를 켜주세요", actionTitle: "위치 서비스 켜기")
            }).disposed(by: bag)
    }
}
