//
//  ObservableType.swift
//  TapRider
//
//  Created by Kaung Soe on 4/24/20.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where Element == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
}
extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}
extension ObservableType {
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    func asDriverOnErrorNever() -> Driver<Element> {
        return asDriver { error in
            return .never()
        }
    }
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
extension Observable {
    func withLatestFrom<T, U, R>(_ other1: Observable<T>, _ other2: Observable<U>, selector: @escaping (Element, T, U) -> R) -> Observable<R> {
        return self.withLatestFrom(Observable<Any>.combineLatest(
            other1,
            other2
        )) { x, y in selector(x, y.0, y.1) }
    }
}
