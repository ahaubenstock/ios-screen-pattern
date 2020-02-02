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
    func install<T>(subject: PublishSubject<T>, presenter: @escaping (Self, PublishSubject<T>, PresenterInput) -> ViewInput)
}

extension Presentable {
    func install<T>(subject: PublishSubject<T>, presenter: @escaping (Self, PublishSubject<T>, PresenterInput) -> ViewInput) {
        _ = rx.methodInvoked(#selector(UIViewController.viewDidLoad))
            .take(1)
            .map { [unowned self] _ in self.presenterInput }
            .map { [unowned self] in presenter(self, subject, $0) }
            .map(bind)
            .skipUntil(rx.deallocated)
            .bind(onNext: {
                $0.forEach { $0.dispose() }
            })
    }
}
