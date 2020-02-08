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
    static func addLogic(to component: DatePickerComponent, input: Date?, observer: AnyObserver<Date>) -> [Disposable] {
        component.nextButton.isHidden = true
        let back = component.backButton.rx.tap
            .withLatestFrom(component.datePicker.rx.date)
            .bind(onNext: {
                observer.onNext($0)
                observer.onCompleted()
            })
        return [
            back
        ]
    }
}
