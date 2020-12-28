//
//  BaseNavigationCoordinator.swift
//  BaseProject
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import UIKit
import XCoordinator

class BaseNavigationCoordinator<T: Route>: NavigationCoordinator<T> {

    func back() -> NavigationTransition {
        if rootViewController.presentedViewController != nil {
            rootViewController.presentedViewController?.dismiss(animated: true)
        } else {
            rootViewController.popViewController(animated: true)
        }
        return .none()
    }

    func popAndPush(route: T) -> NavigationTransition {
        trigger(route)
        let count = rootViewController.viewControllers.count
        if count > 2 {
            rootViewController.viewControllers.remove(at: count - 2)
        }
        return .none()
    }

    func popTwice() -> NavigationTransition {
        let countVC = rootViewController.viewControllers.count
        if countVC > 2 {
            rootViewController.viewControllers.remove(at: countVC - 1)
            rootViewController.popViewController(animated: true)
        } else if countVC == 1 {
            rootViewController.popViewController(animated: true)
        }
        return .none()
    }

    func dismissAndPush(route: T) -> NavigationTransition {
        if rootViewController.presentedViewController != nil {
            rootViewController.presentedViewController?.dismiss(animated: false)
            trigger(route)
        }
        return .none()
    }

    func popToHome() {
        while self.rootViewController.presentedViewController != nil {
            self.rootViewController.presentedViewController?.dismiss(animated: false)
        }
    }

    func addChildAndRemovePrevious<T: Route>(presentable: BaseNavigationCoordinator<T>) -> NavigationTransition {
        if let child = children.filter({ type(of: $0) == type(of: presentable) }).last {
            removeChild(child)
        }
        addChild(presentable)
        return .none()
    }
}
