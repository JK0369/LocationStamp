//
//  SplashCoordinator.swift
//  BaseProject
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import Domain
import CommonExtension
import XCoordinator

indirect enum SplashRoute: Route {
    case splash
    case photo

    case popAndPush(SplashRoute)
}

class SplashCoordinator: BaseNavigationCoordinator<SplashRoute> {
    let postTaskManager: PostTaskManager

    init(rootViewController: RootViewController, postTaskManager: PostTaskManager, initialRoute: SplashRoute) {
        self.postTaskManager = postTaskManager
        super.init(rootViewController: rootViewController, initialRoute: nil)
        trigger(initialRoute)
    }

    override func prepareTransition(for route: SplashRoute) -> NavigationTransition {
        rootViewController.setNavigationBarHidden(true, animated: false)
        switch route {
        case .splash:
            let vc = SplashBuilder.build(router: unownedRouter, postTaskManager: postTaskManager)
            return .set([vc])

        case .photo:
            let coordinator = PhotoCoordinator(
                rootViewController: rootViewController,
                postTaskManager: postTaskManager,
                initialRoute: .photo(nil)
            )
            return .addChild(coordinator)

        case .popAndPush(let route):
            return popAndPush(route: route)
        }
    }

}
