//
//  PhotoVC.swift
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

final class PhotoVC: BaseViewController, StoryboardInitializable, ErrorPresentable {
    static var storyboardName: String = Constants.Storyboard.photo
    static var storyboardID: String = PhotoVC.className

    // MARK: - Propertye

    @IBOutlet weak var btnReverseGeoCoding: UIButton!
    var viewModel: PhotoVM!

    required init?(coder: NSCoder, viewModel: PhotoVM) {
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

    private func btnReverseGeoCodingTapEvent() {
        btnReverseGeoCoding.rx.tap.asDriverOnErrorNever()
            .drive(onNext: { [weak self] in
                self?.viewModel.didTapBtnReverseGeoCoding()
            }).disposed(by: bag)
    }
}
