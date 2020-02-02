//
//  Presentable.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift

protocol Presentable: UIViewController {
    associatedtype PresenterInput
    associatedtype ViewInput
    var presenterInput: PresenterInput { get }
    func bind(input: ViewInput) -> [Disposable]
    func install<T>(subject: PublishSubject<T>, presenter: @escaping (Self, AnyObserver<T>, PresenterInput) -> (ViewInput, [Disposable]))
}

extension Presentable {
    func install<T>(subject: PublishSubject<T>, presenter: @escaping (Self, AnyObserver<T>, PresenterInput) -> (ViewInput, [Disposable])) {
        weak var _self: Self! = self
        let presenterOutput = rx.methodInvoked(#selector(UIViewController.viewDidLoad))
            .take(1)
            .map { _ in _self.presenterInput }
            .map { presenter(_self, subject.asObserver(), $0) }
            .share(replay: 1)
        let disposables = Observable.zip(
                presenterOutput.map { $0.0 }.map { _self.bind(input: $0) },
                presenterOutput.map { $0.1 }
            ) { $0 + $1 }
        _ = rx.deallocated
            .withLatestFrom(disposables)
            .bind(onNext: {
                $0.forEach { $0.dispose() }
            })
        _ = subject
            .materialize()
            .filter { $0.isCompleted }
            .flatMap { _ in Observable<Int>.timer(.seconds(2), scheduler: MainScheduler.instance) }
            .takeUntil(rx.deallocated)
            .bind(onNext: { _ in
                print("⚠️ `\(String(describing: Self.self))` – not released")
            })
    }
}
