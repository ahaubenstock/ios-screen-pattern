//
//  SecondPresenter.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SecondScreen: Screen {
    static func addLogic(to component: SecondComponent, input: Date?, observer: AnyObserver<Date>) -> [Disposable] {
        let back = component.backButton.rx.tap
            .bind(onNext: observer.onCompleted)
        component.datePicker.date = input ?? Date()
        let date = component.datePicker.rx.date
            .bind(onNext: observer.onNext)
        return [
            back,
            date
        ]
    }
}
