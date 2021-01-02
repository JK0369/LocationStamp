//
//  OptionVC.swift
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

final class OptionVC: BaseViewController, StoryboardInitializable, ErrorPresentable {
    static var storyboardName: String = Constants.Storyboard.option
    static var storyboardID: String = OptionVC.className

    // MARK: - Property

    @IBOutlet weak var btnPhoto: UIButton!
    var viewModel: OptionVM!

    required init?(coder: NSCoder, viewModel: OptionVM) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        networkListener = .on
        setupErrorHandlerBinding()
        setupInputBinding()
        setupOutputBinding()
    }

    private func setupInputBinding() {
        viewWillAppearEvent()

        btnPhotoTapEvent()
    }

    private func viewWillAppearEvent() {
        rx.viewWillAppear.asDriverOnErrorNever()
            .mapToVoid()
            .drive(onNext: { [weak self] in
                self?.viewModel.viewWillAppear()
            }).disposed(by: bag)
    }

    private func btnPhotoTapEvent() {
        btnPhoto.rx.tap.asDriverOnErrorNever()
            .drive(onNext: { [weak self] in
                self?.viewModel.didTapBtnPhoto()
            }).disposed(by: bag)
    }

    private func setupOutputBinding() {
        viewModel.requirePhotoPermission.asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] in
                self?.showAlertAndSetting(
                    alertTitle: "사진 접근 권한이 필요합니다",
                    actionTitle: "설정"
                )
            }).disposed(by: bag)
    }
}
