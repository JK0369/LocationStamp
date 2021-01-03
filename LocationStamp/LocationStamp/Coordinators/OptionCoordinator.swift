//
//  OptionCoordinator.swift
//  LocationStamp
//
//  Created by 김종권 on 2020/12/31.
//

import Foundation
import Domain
import CommonExtension
import XCoordinator

indirect enum OptionRoute: Route {
    case option
    case photo

    case present(UIImagePickerController)
    case popAndPush(OptionRoute)
}

class OptionCoordinator: BaseNavigationCoordinator<OptionRoute> {
    let postTaskManager: PostTaskManager

    init(rootViewController: RootViewController, postTaskManager: PostTaskManager, initialRoute: OptionRoute) {
        self.postTaskManager = postTaskManager
        super.init(rootViewController: rootViewController, initialRoute: nil)
        trigger(initialRoute)
    }

    override func prepareTransition(for route: OptionRoute) -> NavigationTransition {

        switch route {
        case .option:
            let vc = OptionBuilder.build(router: unownedRouter, postTaskManager: postTaskManager)
            return .set([vc])

        case .photo:
            let coordinator = PhotoCoordinator(rootViewController: rootViewController, postTaskManager: postTaskManager, initialRoute: .photo)
            return .addChild(coordinator)

        case .present(let vc):
            return .present(vc)

        case .popAndPush(let route):
            return popAndPush(route: route)
        }
    }

}
