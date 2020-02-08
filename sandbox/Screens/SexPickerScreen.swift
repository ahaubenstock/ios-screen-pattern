//
//  SexPickerScreen.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/8/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SexPickerScreen: Screen {
    static func addLogic(to component: SexPickerComponent, input: Profile, observer: AnyObserver<Profile>) -> [Disposable] {
        let back = component.backButton.rx.tap
            .bind(onNext: observer.onCompleted)
        let profile = component.segmentedControl.rx.selectedSegmentIndex
            .map { (index: Int) -> Profile in
                var p = input
                p.sex = index == 0 ? .male : .female
                return p
        }
        let finish = component.doneButton.rx.tap
            .withLatestFrom(profile)
            .bind(onNext: {
                observer.onNext($0)
                observer.onCompleted()
            })
        return [
            back,
            finish
        ]
    }
}
