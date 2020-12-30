//
//  AppDelegate.swift
//  LocationStamp
//
//  Created by 김종권 on 2020/12/29.
//

import UIKit
import Domain
import CommonExtension
import RxSwift
import RxCocoa
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let bag = DisposeBag()
    private let keychain = KeychainService.shared
    var postTaskManager = PostTaskManager()
    lazy var router = SplashCoordinator(rootViewController: UINavigationController(), postTaskManager: self.postTaskManager, initialRoute: .splash).strongRouter
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)
        router.setRoot(for: window!)
        window?.makeKeyAndVisible()

        return true
    }

    private func removeOldKeychainVluesIfNeeded() {
        guard UserDefaults.isFirstLaunch() else {
            return
        }
        keychain.deleteUserInfo()
    }

}

