//
//  OptionBuilder.swift
//  LocationStamp
//
//  Created by 김종권 on 2020/12/31.
//

import Foundation
import Domain
import XCoordinator

class OptionBuilder {
    static func build(router: UnownedRouter<OptionRoute>, postTaskManager: PostTaskManager) -> OptionVC {
        let dependencies = OptionVM.Dependencies(
            router: router
        )
        let vm = OptionVM(dependencies: dependencies)
        return OptionVC.instantiate(viewModel: vm)
    }
}
