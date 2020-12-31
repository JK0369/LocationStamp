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

    // MARK: - Handling View Input

    func viewWillAppear() {
    }

    func didTapBtnConfrim() {
        dependencies.router.trigger(.option)
    }
}

extension InfoVM: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }

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

    @available(iOS 14, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch manager.accuracyAuthorization {
        case .reducedAccuracy:
            requireLocationAuth.accept(())
        default:
            break
        }

    }
}
