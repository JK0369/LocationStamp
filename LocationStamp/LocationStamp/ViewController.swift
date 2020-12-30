//
//  ViewController.swift
//  LocationStamp
//
//  Created by 김종권 on 2020/12/29.
//

import UIKit
import Domain
import Moya
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bag = DisposeBag()

        let usecase = MoyaProvider<ReverseGeoCodingTarget>.makeProvider()
        let request = ReverseGeoCodingRequest(latitude: 37.325130462646484, longitude: 127.1183853149414)
        usecase.rx.request(.reverseGeoCoding(request))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (result) in
                switch result {
                case .success(let response):
                    print(response)
                case .error(let error):
                    print(error)
                }
            }.disposed(by: bag)
    }
}

