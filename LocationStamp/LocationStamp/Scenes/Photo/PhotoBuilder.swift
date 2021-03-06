//
//  PhotoBuilder.swift
//  LocationStamp
//
//  Created by 김종권 on 2020/12/31.
//

import Foundation
import Domain
import XCoordinator
import Moya

class PhotoBuilder {
    static func build(router: UnownedRouter<PhotoRoute>, postTaskManager: PostTaskManager, image: UIImage?) -> PhotoVC {
        let dependencies = PhotoVM.Dependencies(
            router: router,
            ReverseGeoCodingUsecase: MoyaProvider<ReverseGeoCodingTarget>.makeProvider(),
            image: image
        )
        let vm = PhotoVM(dependencies: dependencies)
        return PhotoVC.instantiate(viewModel: vm)
    }
}
