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

class PhotoVM: ErrorHandleable {

    var locationManager: CLLocationManager!

    struct Dependencies {
        let router: UnownedRouter<PhotoRoute>
        let ReverseGeoCodingUsecase: MoyaProvider<ReverseGeoCodingTarget>
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Output

    var showError = PublishRelay<ErrorData>()
    let location = PublishRelay<LocationInfo>()

    // MARK: - Properties

    let dependencies: Dependencies
    let bag = DisposeBag()

    // MARK: - Handling View Input

    func viewWillAppear() {
    }

    func didTapBtnReverseGeoCoding() {

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

    private func coordinate() -> Coordinate {
        locationManager = CLLocationManager()
        let coordinate = locationManager.location?.coordinate
        let lat = Double(coordinate?.latitude ?? 0)
        let lng = Double(coordinate?.longitude ?? 0)
        return Coordinate(lat: lat, lng: lng)
    }
}
