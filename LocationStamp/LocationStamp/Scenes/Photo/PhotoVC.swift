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

    @IBOutlet weak var btnPhoto: UIButton!
    @IBOutlet weak var btnCamera: UIButton!
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
        setupView()
        networkListener = .on
        setupErrorHandlerBinding()
        setupInputBinding()
        setupOutputBinding()
    }

    private func setupView() {
        btnCamera.setFloatingStyle()
        btnPhoto.setFloatingStyle()
    }

    private func setupInputBinding() {
        viewWillAppearEvent()

        btnPhotoTapEvent()

        btnSaveTapEvent()

        btnCameraTapEvent()

        btnBackTapEvent()
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

    private func btnSaveTapEvent() {
        btnSave.rx.tap.asDriverOnErrorNever()
            .drive(onNext: { [weak self] in
                guard let stampImageView = self?.imageView, let textLocation = self?.lblLocation.text, let isFromCamera = self?.viewModel.isFromCamera else {
                    return
                }
                guard let stampImage = stampImageView.createImageWithLabelOverlay(text: textLocation, isFromCamera: isFromCamera) else {
                    return
                }
                UIImageWriteToSavedPhotosAlbum(stampImage, nil, nil, nil)
                self?.showToastView(message: "사진이 저장 되었습니다")
            }).disposed(by: bag)
    }

    private func btnCameraTapEvent() {
        btnCamera.rx.tap.asDriverOnErrorNever()
            .drive(onNext: { [weak self] in
                self?.viewModel.didTapBtnCamera()
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
