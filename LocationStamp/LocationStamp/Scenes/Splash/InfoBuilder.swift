//
//  InfoBuilder.swift
//  LocationStamp
//
//  Created by 김종권 on 2020/12/31.
//

import Foundation
import Domain
import XCoordinator

class InfoBuilder {
    static func build(router: UnownedRouter<SplashRoute>, postTaskManager: PostTaskManager) -> InfoVC {
        let dependencies = InfoVM.Dependencies(
            router: router
        )
        let vm = InfoVM(dependencies: dependencies)
        return InfoVC.instantiate(viewModel: vm)
    }
}
