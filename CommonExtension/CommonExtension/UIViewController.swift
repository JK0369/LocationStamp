//
//  UIViewController.swift
//  ComfortDelGro
//
//  Created by Kaung Soe on 2/8/19.
//  Copyright © 2019 Codigo. All rights reserved.
//

import UIKit
import SafariServices
//import Hero

public extension UIViewController {
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func popVCToBottom() {
        navigationController?.popToBottom()
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func prepareForSlideupAnimation() {
        //hero.isEnabled = true
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    func prepareForFadeInAnimation() {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
//    func slideup(_ view: UIView) {
//        view.hero.modifiers = [.duration(0.4), .translate(y: view.frame.height), .useGlobalCoordinateSpace]
//    }
    
    var isPresentedModally: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar || false
    }
    
	func showAlert(title: String? = "", message: String?, actionTitle: String = "OK", actionCallback: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (_) in
            actionCallback?()
        }))
        alertController.addAction(.init(title: "취소", style: .cancel, handler: { [weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String? = "", message: String?, positiveTitle: String = "Yes", positiveAction: (() -> Void)? = nil, negativeTitle: String = "No", negativeAction:  (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: negativeTitle, style: .default, handler: { (_) in
            if negativeAction == nil { alertController.dismiss(animated: true, completion: nil) }
            negativeAction?()
        }))
        
        alertController.addAction(UIAlertAction(title: positiveTitle, style: .default, handler: { (_) in
            if positiveAction == nil { alertController.dismiss(animated: true, completion: nil) }
            positiveAction?()
        }))
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func showInputAlert(title: String? = "", message: String? = "", submitAction: ((String) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Postal Code"
            textField.clearButtonMode = .whileEditing
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        })

        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            let inputText = alert?.textFields![0].text ?? "" // Force unwrapping because we know it exists.
            submitAction?(inputText)
            alert?.dismiss(animated: true, completion: nil)
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func openURL(_ url: String) {
        if let url = URL(string: url) {
            if #available(iOS 11.0, *) {
                let vc = SFSafariViewController(url: url)
                present(vc, animated: true)
            } else {
                UIApplication.shared.open(url, options: [:])
            }
            
        }
    }
    
    func openURLInSafari(_ url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func replaceRootVC(with vc: UIViewController, duration: TimeInterval = 0.4, options: UIView.AnimationOptions = .transitionCrossDissolve) {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController = vc
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
    }
    
    @objc
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func call(phone no: String) {
        guard let url = URL(string: "tel://\(no)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    static func canOpenGoogleMap() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)
    }
    
    static func canOpenAppleMap() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "http://maps.apple.com/maps")!)
    }
    
    func openGoogleMap(with coordinate: (lat: String, long: String)) {
         guard let url = URL(string: "comgooglemaps://?q=\(coordinate.lat),\(coordinate.long)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func openAppleMap(with coordinate: (lat: String, long: String)) {
        guard let url = URL(string: "http://maps.apple.com/maps?saddr=\(coordinate.lat),\(coordinate.long)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func openAppStore(using url: String) {
        
        guard let url = URL(string: url) else {
            print("invalid app store url")
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("can't open app store url")
        }
    }
}
