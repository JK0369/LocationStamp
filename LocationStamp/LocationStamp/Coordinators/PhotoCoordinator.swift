//
//  PhotoCoordinator.swift
//  LocationStamp
//
//  Created by 김종권 on 2020/12/31.
//

import Foundation
import Domain
import CommonExtension
import XCoordinator

indirect enum PhotoRoute: Route {
    case photo

    case popAndPush(PhotoRoute)
}

class PhotoCoordinator: BaseNavigationCoordinator<PhotoRoute> {
    let postTaskManager: PostTaskManager

    init(rootViewController: RootViewController, postTaskManager: PostTaskManager, initialRoute: PhotoRoute) {
        self.postTaskManager = postTaskManager
        super.init(rootViewController: rootViewController, initialRoute: nil)
        trigger(initialRoute)
    }

    override func prepareTransition(for route: PhotoRoute) -> NavigationTransition {
        switch route {
        case .photo:
            let vc = PhotoBuilder.build(router: unownedRouter, postTaskManager: postTaskManager)
            return .push(vc)

        case .popAndPush(let route):
            return popAndPush(route: route)
        }
    }

}