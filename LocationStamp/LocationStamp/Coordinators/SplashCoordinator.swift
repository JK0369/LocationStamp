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
            
//        case let .showUpdateDialog(message, onUpdate):
//            let vc = VersionUpdateDialogVC.instantiate()
//            vc.message = message
//            vc.onUpdate
//                .bind(onNext: onUpdate)
//                .disposed(by: vc.bag)
//            return .present(vc)

//        case let .terms(phoneNumber, email, smsOTP):
//            let termsCoordinator = TermsCoordinator(
//                rootViewController: rootViewController,
//                postTaskManager: postTaskManager,
//                initialRoute: .terms(phoneNumber: phoneNumber, email: email, smsOTP: smsOTP)
//            )
//            return .addChild(termsCoordinator)
        }
    }

}
