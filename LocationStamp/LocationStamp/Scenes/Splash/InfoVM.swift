//
//  InfoVM.swift
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
import CoreLocation

class InfoVM: NSObject, ErrorHandleable {

    var locationManager: CLLocationManager!

    struct Dependencies {
        let router: UnownedRouter<SplashRoute>
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }

    // MARK: - Output

    var showError = PublishRelay<ErrorData>()
    let requireLocationAuth = PublishRelay<Void>()

    // MARK: - Properties

    let dependencies: Dependencies
    let bag = DisposeBag()
    var isTapBtnConfirmMoreThanOnce = false
    var isSelectedAfterRequest = false

    // MARK: - Handling View Input

    func viewWillAppear() {
    }

    func didTapBtnConfrim() {
        checkLocationPermission()
    }

    private func checkLocationPermission() {
        let currentState = CLLocationManager.authorizationStatus()
        switch currentState {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .notDetermined:
            if isSelectedAfterRequest {
                requireLocationAuth.accept(())
            } else {
                locationManager.requestAlwaysAuthorization()
                locationManager.requestLocation()
                isSelectedAfterRequest = true
            }
            return
        default:
            requireLocationAuth.accept(())
            return
        }

        if #available(iOS 14.0, *) {
            let accuracyState = CLLocationManager().accuracyAuthorization
            switch accuracyState {
            case .reducedAccuracy:
                requireLocationAuth.accept(())
                return
            default:
                dependencies.router.trigger(.option)
                break
            }
        } else {
            dependencies.router.trigger(.option)
        }
    }

}

extension InfoVM: CLLocationManagerDelegate {
    // 시스템 팝업에서 권한 거부를 선택한 경우의 delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        checkLocationPermission()
    }

    // 시스템 팝업에서 동의 관련 권한을 선택한 경우의 delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .notDetermined, .restricted:
            requireLocationAuth.accept(())
        default:
            dependencies.router.trigger(.option)
            break
        }
    }

    // 주의: 해당 함수는 locationManager객체가 만들어질때 delegate함수 실행
    @available(iOS 14, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard isTapBtnConfirmMoreThanOnce == true else {
            isTapBtnConfirmMoreThanOnce = true
            return
        }

        switch manager.accuracyAuthorization {
        case .reducedAccuracy:
            requireLocationAuth.accept(())
        default:
            dependencies.router.trigger(.option)
            break
        }

    }
}
