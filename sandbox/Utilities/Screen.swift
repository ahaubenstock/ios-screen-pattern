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
    associatedtype Output
    associatedtype ViewControllerType: ScreenViewController
    static func create() -> (UIViewController, Observable<Output>)
    static func presenter(controller: ViewControllerType, subject: PublishSubject<Output>, input: ViewControllerType.PresenterInput) -> ViewControllerType.ViewInput
}

extension Screen {
    static func create() -> (UIViewController, Observable<Output>) {
        let controller = ViewControllerType.fromStoryboard()
        let subject = PublishSubject<Output>()
        controller.install(subject: subject, presenter: presenter)
        return (controller, subject)
    }
}
