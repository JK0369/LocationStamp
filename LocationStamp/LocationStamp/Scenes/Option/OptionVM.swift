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

class OptionVM: ErrorHandleable {

    struct Dependencies {
        let router: UnownedRouter<OptionRoute>
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Output

    var showError = PublishRelay<ErrorData>()
    let requirePhotoPermission = PublishRelay<Void>()

    // MARK: - Properties

    let dependencies: Dependencies
    let bag = DisposeBag()

    // MARK: - Handling View Input

    func viewWillAppear() {
    }

    func didTapBtnPhoto() {
        checkPhotoPermission()
    }

    private func checkPhotoPermission() {
        let state = PHPhotoLibrary.authorizationStatus()

        switch state {
        case .authorized:
            dependencies.router.trigger(.photo)
        case .denied:
            requirePhotoPermission.accept(())
        default: // .limited, .restricted, .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] (status) in
                switch status {
                case .authorized:
                    self?.dependencies.router.trigger(.photo)
                case .denied:
                    self?.requirePhotoPermission.accept(())
                default:
                    break
                }
            }
        }
    }

}
