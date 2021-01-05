//
//  OptionVM.swift
//  LocationStamp
//
//  Created by 김종권 on 2020/12/31.
//

import Foundation
import CommonExtension
import Domain
import RxSwift
import RxCocoa
import XCoordinator
import Photos
import AVFoundation

class OptionVM: NSObject, ErrorHandleable {

    struct Dependencies {
        let router: UnownedRouter<OptionRoute>
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    let imagePickerController = UIImagePickerController()

    // MARK: - Output

    var showError = PublishRelay<ErrorData>()
    let requirePermission = PublishRelay<String>()

    // MARK: - Properties

    let dependencies: Dependencies
    let bag = DisposeBag()

    // MARK: - Handling View Input

    func viewWillAppear() {
        imagePickerController.delegate = self
    }

    func didTapBtnPhoto() {
        checkPhotoPermission()
    }

    func didTapBtnCamera() {
        checkCameraPermission()
    }

    
    private func checkCameraPermission() {
        imagePickerController.sourceType = .camera
        AVCaptureDevice.requestAccess(for: .video) { [weak self] (granted: Bool) in
            if granted {
                self?.presentToImagePicker()
                return
            }
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            switch status {
            case .authorized:
                self?.presentToImagePicker()
            default:
                self?.requirePermission.accept("카메라")
            }

        }
    }

    private func presentToImagePicker() {
        DispatchQueue.main.async { [weak self] in
            guard let imagePickerController = self?.imagePickerController else {
                return
            }
            self?.dependencies.router.trigger(.present(imagePickerController))
        }
    }

    private func checkPhotoPermission() {imagePickerController.sourceType = .photoLibrary
        let state = PHPhotoLibrary.authorizationStatus()

        switch state {
        case .authorized:
            dependencies.router.trigger(.photo(nil))
        case .denied:
            requirePermission.accept("사진")
        default: // .limited, .restricted, .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] (status) in
                switch status {
                case .authorized:
                    self?.dependencies.router.trigger(.photo(nil))
                case .denied:
                    self?.requirePermission.accept("사진")
                default:
                    break
                }
            }
        }
    }

}

extension OptionVM: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dependencies.router.trigger(.dismiss)
            dependencies.router.trigger(.photo(image))
        }
    }
}
