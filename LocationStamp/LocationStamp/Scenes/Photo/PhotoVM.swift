//
//  PhotoVM.swift
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
import Moya
import CoreLocation
import AVFoundation
import Photos

class PhotoVM: NSObject, ErrorHandleable {

    var locationManager: CLLocationManager!
    var imagePickerController = UIImagePickerController()
    var isFromCamera: Bool = false {
        didSet {
            if oldValue {
                self.imagePickerController.sourceType = .camera
            } else {
                self.imagePickerController.sourceType = .photoLibrary
            }
        }
    }

    struct Dependencies {
        let router: UnownedRouter<PhotoRoute>
        let ReverseGeoCodingUsecase: MoyaProvider<ReverseGeoCodingTarget>
        let image: UIImage?
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        imagePickerController.delegate = self

        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification)
            .asDriverOnErrorNever()
            .mapToVoid()
            .drive(onNext: { [weak self] in
                self?.checkPhotoPermission(completion: nil)
                self?.checkLocationPermission(completion: nil)
            }).disposed(by: bag)
    }

    // MARK: - Output

    var showError = PublishRelay<ErrorData>()
    let location = PublishRelay<LocationInfo>()
    let updateImage = PublishRelay<UIImage>()
    let requirePermission = PublishRelay<String>()

    // MARK: - Properties

    let dependencies: Dependencies
    let bag = DisposeBag()

    // MARK: - Handling View Input

    func viewWillAppear() {
        imagePickerController.sourceType = .photoLibrary
        checkPhotoPermission { [weak self] in
            if let image = self?.dependencies.image {
                self?.updateImage.accept(image)
                self?.reverseGeoCoding()
                self?.isFromCamera = true
            }
        }
    }

    private func reverseGeoCoding() {

        let coor = coordinate()
        if coor.lat == 0 {
            return
        }

        let request = ReverseGeoCodingRequest(latitude: coor.lat, longitude: coor.lng)
        dependencies.ReverseGeoCodingUsecase.rx.request(.reverseGeoCoding(request))
            .map(ReverseGeoCodingResponse.self)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (result) in
                switch result {
                case .success(let response):
                    let priocipalSubdivision = response.principalSubdivision
                    let city = response.city
                    let locality = response.locality
                    let lat = response.latitude
                    let lng = response.longitude
                    let locationInfo = LocationInfo(
                        pricipalSubdivision: priocipalSubdivision,
                        city: city,
                        locality: locality,
                        lat: lat,
                        lng: lng
                    )
                    self?.location.accept(locationInfo)

                case .error(let error):
                    self?.handleError(error)
                }
            }.disposed(by: bag)
    }

    func didTapBtnPhoto() {
        isFromCamera = false
        routeToPicker()
    }

    func didTapBtnCamera() {
        isFromCamera = true
        checkCameraPermission { [weak self] in
            self?.routeToPicker()
        }
    }

    private func coordinate() -> Coordinate {
        let coordinate = locationManager.location?.coordinate
        let lat = Double(coordinate?.latitude ?? 0)
        let lng = Double(coordinate?.longitude ?? 0)
        return Coordinate(lat: lat, lng: lng)
    }

    private func routeToPicker() {
        DispatchQueue.main.async { [weak self] in
            guard let vc = self?.imagePickerController else {
                return
            }
            self?.dependencies.router.trigger(.present(vc))
        }
    }
}

extension PhotoVM: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dependencies.router.trigger(.back)
            checkLocationPermission { [weak self] in
                self?.updateImage.accept(image)
                self?.reverseGeoCoding()
            }
        }
    }
}

extension PhotoVM: CLLocationManagerDelegate {
    // 시스템 팝업에서 권한 거부를 선택한 경우의 delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        checkLocationPermission { [weak self] in
            self?.requirePermission.accept("위치")
        }
    }

    // 시스템 팝업에서 동의 관련 권한을 선택한 경우의 delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .notDetermined, .restricted:
            requirePermission.accept("위치")
        default:
            reverseGeoCoding()
            break
        }
    }

    // locatoinManager객체가 생겨나면 호출되는 함수이므로 주의
    @available(iOS 14, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch manager.accuracyAuthorization {
        case .reducedAccuracy:
            requirePermission.accept("위치")
        default:
            reverseGeoCoding()
            break
        }

    }
}

// MARK: - Check permission

extension PhotoVM {
    private func checkCameraPermission(completion: (() -> Void)?) {
        imagePickerController.sourceType = .camera
        imagePickerController.cameraFlashMode = .off
        AVCaptureDevice.requestAccess(for: .video) { [weak self] (granted: Bool) in
            if granted {
                completion?()
                return
            }
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            switch status {
            case .authorized:
                completion?()
                return
            default:
                self?.requirePermission.accept("카메라")
            }

        }
    }

    private func checkPhotoPermission(completion: (() -> Void)?) {
        imagePickerController.sourceType = .photoLibrary
        let state = PHPhotoLibrary.authorizationStatus()

        switch state {
        case .authorized:
            completion?()
        case .denied:
            requirePermission.accept("사진")
            return
        default: // .limited, .restricted, .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] (status) in
                switch status {
                case .authorized:
                    completion?()
                case .denied:
                    self?.requirePermission.accept("사진")
                default:
                    return
                }
            }
            return
        }
    }

    private func checkLocationPermission(completion: (() -> Void)?) {
        let currentState = CLLocationManager.authorizationStatus()
        switch currentState {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        default:
            requirePermission.accept("위치")
            return
        }

        if #available(iOS 14.0, *) {
            let accuracyState = CLLocationManager().accuracyAuthorization
            switch accuracyState {
            case .reducedAccuracy:
                requirePermission.accept("위치")
                return
            default:
                completion?()
                break
            }
        } else {
            completion?()
        }
    }

}
