//
//  FourthScreen.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/7/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FourthScreen: Screen {
    static func addLogic(to component: FourthComponent, input: Void, observer: AnyObserver<String>) -> [Disposable] {
        let back = component.backButton.rx.tap
            .bind(onNext: observer.onCompleted)
        let choice = Observable.merge(
            component.appleButton.rx.tap.map { "apple" },
            component.bananaButton.rx.tap.map { "banana" },
            component.orangeButton.rx.tap.map { "orange" }
        )
            .bind(onNext: {
                observer.onNext($0)
                observer.onCompleted()
            })
        return [
            back,
            choice
        ]
    }
}
