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

class PhotoVM: NSObject, ErrorHandleable {

    var locationManager: CLLocationManager!
    var imagePickerController = UIImagePickerController()
    var isFromCamera = false

    struct Dependencies {
        let router: UnownedRouter<PhotoRoute>
        let ReverseGeoCodingUsecase: MoyaProvider<ReverseGeoCodingTarget>
        let image: UIImage?
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
        DispatchQueue.main.async {
            self.imagePickerController.delegate = self
        }
    }

    // MARK: - Output

    var showError = PublishRelay<ErrorData>()
    let location = PublishRelay<LocationInfo>()
    let updateImage = PublishRelay<UIImage>()

    // MARK: - Properties

    let dependencies: Dependencies
    let bag = DisposeBag()

    // MARK: - Handling View Input

    func viewWillAppear() {
        if let image = dependencies.image {
            updateImage.accept(image)
            reverseGeoCoding()
            isFromCamera = true
            return
        }
        imagePickerController.sourceType = .photoLibrary
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
        routeToPicker(vc: imagePickerController)
    }

    private func coordinate() -> Coordinate {
        locationManager = CLLocationManager()
        let coordinate = locationManager.location?.coordinate
        let lat = Double(coordinate?.latitude ?? 0)
        let lng = Double(coordinate?.longitude ?? 0)
        return Coordinate(lat: lat, lng: lng)
    }

    private func routeToPicker(vc: UIImagePickerController) {
        dependencies.router.trigger(.present(vc))
    }
}

extension PhotoVM: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            updateImage.accept(image)
            reverseGeoCoding()
        }
        dependencies.router.trigger(.back)
    }
}
