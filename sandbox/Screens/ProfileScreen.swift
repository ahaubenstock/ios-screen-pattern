//
//  ProfileScreen.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/8/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Sex {
    case male
    case female
}

struct Name {
    var first: String
    var last: String
}

struct Profile {
    var name: Name
    var dateOfBirth: Date
    var sex: Sex
	var phoneNumber: String
}

let emptyProfile = Profile(name: Name(first: "", last: ""), dateOfBirth: Date(), sex: .male, phoneNumber: "")

final class ProfileScreen: Flow {
    static func addLogic(to component: NameComponent, input: Void, observer: AnyObserver<Profile>) -> [Disposable] {
        let cancel = component.cancelButton.rx.tap
            .bind(onNext: observer.onCompleted)
        let profile = Observable.combineLatest(
            component.firstNameField.rx.text.orEmpty.asObservable(),
            component.lastNameField.rx.text.orEmpty.asObservable()
        )
            .map { (first: String, last: String) -> Profile in
                var p = emptyProfile
                p.name.first = first
                p.name.last = last
                return p
            }
        let next = component.nextButton.rx.tap
            .withLatestFrom(profile)
            .flatMap(flow(to: DateOfBirthScreen.self, from: component))
            .bind(onNext: {
                observer.onNext($0)
                observer.onCompleted()
            })
        return [
            cancel,
            next
        ]
    }
}
