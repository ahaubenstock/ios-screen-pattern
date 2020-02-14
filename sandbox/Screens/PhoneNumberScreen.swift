//
//  PhoneNumberScreen.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/13/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private func format(phoneNumber number: String) -> String {
	var result = ""
	if number.count >= 1 {
		result += "(\(number.prefix(3))"
	}
	if number.count >= 3 {
		result += ") "
	}
	if number.count >= 4 {
		result += number.dropFirst(3).prefix(3)
	}
	if number.count >= 6 {
		result += "-"
	}
	if number.count >= 7 {
		result += number.dropFirst(6).prefix(4)
	}
	return result
}

final class PhoneNumberScreen: Flow {
    static func addLogic(to component: PhoneNumberComponent, input: Profile, observer: AnyObserver<Profile>) -> [Disposable] {
		let back = component.backButton.rx.tap
			.bind(onNext: observer.onCompleted)
		let phoneNumber = BehaviorSubject(value: "")
		let numberRaw = component.numberField.rx.text.orEmpty
			.withLatestFrom(phoneNumber) { ($0, $1) }
			.map { (text: String, phone: String) -> String in
				var drop = 0
				if text.count < format(phoneNumber: phone).count {
					if text.count == 5 { drop = 2 }
					if text.count == 9 { drop = 1 }
				}
				return String(text.dropLast(drop))
			}
			.map { $0.filter { $0.isNumber }.map { String($0) }.joined(separator: "") }
			.bind(to: phoneNumber)
		let numberDisplay = phoneNumber
			.map(format)
			.bind(to: component.numberField.rx.text)
		let profile = phoneNumber
			.map { (number: String) -> Profile in
				var p = input
				p.phoneNumber = number
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
			numberRaw,
			numberDisplay,
			next
        ]
    }
}
