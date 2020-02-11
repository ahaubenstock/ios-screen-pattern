//
//  DateOfBirthScreen.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/8/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DateOfBirthScreen: Flow {
    static func addLogic(to component: DatePickerComponent, input: Profile, observer: AnyObserver<Profile>) -> [Disposable] {
		component.headerLabel.text = "when is your birthday?"
        let back = component.backButton.rx.tap
            .bind(onNext: observer.onCompleted)
        let profile = component.datePicker.rx.date
            .map { (date: Date) -> Profile in
                var p = input
                p.dateOfBirth = date
                return p
            }
        let next = component.nextButton.rx.tap
            .withLatestFrom(profile)
            .flatMap(flow(to: SexPickerScreen.self, from: component))
            .bind(onNext: {
                observer.onNext($0)
                observer.onCompleted()
            })
        return [
            back,
            next
        ]
    }
}
