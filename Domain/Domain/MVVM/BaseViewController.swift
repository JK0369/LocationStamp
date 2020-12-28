//
//  BaseViewController.swift
//  BaseVC
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation
import UIKit
import Toast_Swift
import JGProgressHUD
import RxSwift
import RxCocoa
import Reachability
import RxReachability

public enum NetworkListener: Int {
    case off = 0
    case on = 1
}

open class BaseViewController: UIViewController {

    public let bag = DisposeBag()
    public lazy var hud: JGProgressHUD = {
        let loader = JGProgressHUD(style: .dark)
        return loader
    }()

    // network
    public var reachability: Reachability? // 이 변수를 바인딩 하여 네트워크 상태 점검
    public let isConnected: PublishSubject<Bool> = .init() // 사용하는 입장에서 network 상태를 보고 사용할 용도의 변수
    public var networkListener: NetworkListener = .off { // 네트워크 체크가 필요할 시 VC에서 netwrokListener = .on으로 설정
        didSet {
            if networkListener  == .on {
                setupReachabilityBindings()
            }
        }
    }

    // init
    open override func viewDidLoad() {
        super.viewDidLoad()
        reachability = Reachability()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? reachability?.startNotifier()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reachability?.stopNotifier()
    }

    // toast
    public func showToastView(message: String, point: CGPoint? = nil) {
        let messageView = ToastMessageView(frame: CGRect(x: 0, y: 0, width: 248, height: 48))
        messageView.layer.cornerRadius = messageView.bounds.height / 2
        messageView.clipsToBounds = true
        messageView.lblToastMessage.text = message

        if let point = point {
            view.showToast(messageView, point: point)
        } else {
            view.showToast(messageView)
        }
    }

    // Loading
    public func showLoading() {
        DispatchQueue.main.async {
            self.hud.show(in: self.view, animated: true)
        }
    }
    public func hideLoading() {
        DispatchQueue.main.async {
            self.hud.dismiss(animated: true)
        }
    }

    // Alert and open setting
    public func showAlertAndSetting(alertTitle: String, actionTitle: String) {
        showAlert(title: alertTitle, message: nil, actionTitle: actionTitle) { [weak self] in
            self?.openSettingsInApp()
        }
    }
    private func openSettingsInApp() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, completionHandler: nil)
            }
        }
    }

    // Network
    private func setupReachabilityBindings() {
        reachability?.rx.reachabilityChanged
            .subscribe(onNext: { reachability in
                print("reachability: changed => \(reachability.connection)")
            })
            .disposed(by: bag)

        reachability?.rx.isReachable
            .filter { !$0 }
            .map { _ in "server Error" }
            .asDriver(onErrorRecover: { _ in .never()})
            .drive(rx.showServerErrorDialog)
            .disposed(by: bag)

        reachability?.rx.isConnected
            .map { _ in true }
            .bind(to: isConnected)
            .disposed(by: bag)

        reachability?.rx.isDisconnected
            .map { _ in false }
            .bind(to: isConnected)
            .disposed(by: bag)
    }
}

public extension Reactive where Base: BaseViewController {
    var showLoading: Binder<Void> {
        return Binder(self.base) { (vc, show) in
            vc.showLoading()
        }
    }
    var hideLoading: Binder<Void> {
        return Binder(self.base) { (vc, show) in
            vc.hideLoading()
        }
    }

    var backPressed: Binder<Void> {
        return Binder(base) { vc, _ in
            vc.view.endEditing(true)
            if vc.navigationController != nil {
                vc.navigationController?.popViewController(animated: true)
            } else {
                vc.dismiss(animated: true)
            }
        }
    }

    // Dialog

    var showErrorMessageDialog: Binder<ErrorData> {
        return Binder(base) { vc, data in
            let dialogVC = DialogBuilder.showErrorMessageDialog(data)
            vc.present(dialogVC, animated: true)
        }
    }

    var showServerErrorDialog: Binder<String> {
        return Binder(base) { (vc, errorMsg) in
            debugPrint(errorMsg)
            let dialogVC = DialogBuilder.serverErrorDialog()
            vc.present(dialogVC, animated: true)
        }
    }
}
