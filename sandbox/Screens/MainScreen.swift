//
//  MainScreen.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//	Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MainScreen: Screen {
    static func addLogic(to component: MainComponent, input: Void, observer: AnyObserver<Void>) -> [Disposable] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        var date: Date?
        let hidden = component.button.rx.tap
            .flatMapLatest { Observable<Int>.timer(.seconds(3), scheduler: MainScheduler.instance).map { _ in true }.startWith(false) }.startWith(true)
            .bind(to: component.label.rx.isHidden)
        let dateText = component.chooseDateButton.rx.tap
            .map { _ in date }
            .flatMap(use(SecondScreen.self, from: component))
            .do(onNext: { date = $0 })
            .map(dateFormatter.string)
            .bind(to: component.dateLabel.rx.text)
        let third = component.goToThirdButton.rx.tap
            .flatMap(use(ThirdScreen.self, from: component))
            .bind(to: component.choiceLabel.rx.text)
        let profile = component.makeProfileButton.rx.tap
            .flatMap(use(ProfileScreen.self, from: component))
            .map { "\($0)" }
            .bind(to: component.profileLabel.rx.text)
        return [
            hidden,
            dateText,
            third,
            profile
        ]
    }
}
