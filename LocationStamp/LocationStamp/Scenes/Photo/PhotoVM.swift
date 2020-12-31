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

struct LocationInfo {
    let PricipalSubdivision: String
    let city: String
    let locality: String
    let lat: Double
    let lng: Double

    func location() -> String {
        PricipalSubdivision + " " + city + " " + locality
    }
}

class PhotoVM: ErrorHandleable {

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
        let request = ReverseGeoCodingRequest(latitude: 37.325130462646484, longitude: 127.1183853149414)
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
                        PricipalSubdivision: priocipalSubdivision,
                        city: city,
                        locality: locality,
                        lat: lat,
                        lng: lng
                    )
                    self?.location.accept(locationInfo)

                case .error(let error):
                    print(error)
                }
            }.disposed(by: bag)
    }

}
