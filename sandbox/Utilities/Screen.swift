//
//  Screen.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import Foundation
import RxSwift

protocol ScreenViewController: Presentable, HasStoryboard {}

protocol Screen: class {
    associatedtype Input
    associatedtype Output
    associatedtype ViewControllerType: ScreenViewController
    static func create(input: Input) -> (UIViewController, Observable<Output>)
    static func presenter(controller: ViewControllerType, screenInput: Input, observer: AnyObserver<Output>, uiInput: ViewControllerType.PresenterInput) -> (ViewControllerType.ViewInput, [Disposable])
}

extension Screen {
    static func create(input: Input) -> (UIViewController, Observable<Output>) {
        let controller = ViewControllerType.fromStoryboard()
        let subject = PublishSubject<Output>()
        let _presenter = { [unowned controller] uiInput in
            presenter(controller: controller, screenInput: input, observer: subject.asObserver(), uiInput: uiInput)
        }
        controller.install(_presenter)
        _ = subject
            .materialize()
            .filter { $0.isCompleted }
            .flatMap { _ in Observable<Int>.timer(.seconds(2), scheduler: MainScheduler.instance) }
            .takeUntil(controller.rx.deallocated)
            .bind(onNext: { _ in
                print("⚠️ `\(String(describing: Self.ViewControllerType.self))` – not released")
            })
        return (controller, subject)
    }
}
extension Screen where Input == Void {
    static func create() -> (UIViewController, Observable<Output>) {
        return create(input: ())
    }
}
