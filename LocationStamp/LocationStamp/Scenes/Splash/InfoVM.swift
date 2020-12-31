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
        locationManager = CLLocationManager()
//        locationManager.delegate = self
    }

    // MARK: - Output

    var showError = PublishRelay<ErrorData>()

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
    
}
