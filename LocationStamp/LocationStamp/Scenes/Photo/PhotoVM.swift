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

    // MARK: - Properties

    let dependencies: Dependencies
    let bag = DisposeBag()

    // MARK: - Handling View Input

    func viewWillAppear() {
    }

    func didTapBtnReverseGeoCoding() {
        let request = ReverseGeoCodingRequest(latitude: 37.325130462646484, longitude: 127.1183853149414)
        dependencies.ReverseGeoCodingUsecase.rx.request(.reverseGeoCoding(request))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (result) in
                switch result {
                case .success(let response):
                    print(response)
                case .error(let error):
                    print(error)
                }
            }.disposed(by: bag)
    }

}
