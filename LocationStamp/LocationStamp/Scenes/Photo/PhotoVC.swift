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

    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewEmpty: UIView!

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
        setupOutputBinding()
    }

    private func setupInputBinding() {
        viewWillAppearEvent()

        btnSelectTapEvent()

        btnSaveTapEvent()

        btnBackTapEvent()
    }

    private func viewWillAppearEvent() {
        rx.viewWillAppear.asDriverOnErrorNever()
            .mapToVoid()
            .drive(onNext: { [weak self] in
                self?.viewModel.viewWillAppear()
            }).disposed(by: bag)
    }

    private func btnSelectTapEvent() {
        btnSelect.rx.tap.asDriverOnErrorNever()
            .drive(onNext: { [weak self] in
                self?.viewModel.didTapBtnSelect()
            }).disposed(by: bag)
    }

    private func btnSaveTapEvent() {
        btnSave.rx.tap.asDriverOnErrorNever()
            .drive(onNext: { [weak self] in
                guard let stampImageView = self?.imageView, let textLocation = self?.lblLocation.text else {
                    return
                }
                guard let stampImage = stampImageView.createImageWithLabelOverlay(text: textLocation) else {
                    return
                }
                UIImageWriteToSavedPhotosAlbum(stampImage, nil, nil, nil)
                self?.showToastView(message: "사진이 저장 되었습니다")
            }).disposed(by: bag)
    }

    private func btnBackTapEvent() {
        btnBack.rx.tap.asDriverOnErrorNever()
            .drive(rx.backPressed)
            .disposed(by: bag)
    }

    // MARK: - OutputBinding

    private func setupOutputBinding() {
        viewModel.location.asDriverOnErrorNever()
            .drive(onNext: { [weak self] (locationInfo) in
                self?.lblLocation.isHidden = false
                self?.lblLocation.text = locationInfo.location(locationScope: .gps)
            }).disposed(by: bag)

        viewModel.updateImage.asDriverOnErrorNever()
            .drive(onNext: { [weak self] (image) in
                self?.imageView.image = image
                self?.viewEmpty.isHidden = true
            }).disposed(by: bag)
    }
}
