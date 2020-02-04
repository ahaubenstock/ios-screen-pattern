//
//  MainPresenter.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//	Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift

typealias MainInput = Void
typealias MainOutput = Void

final class Main: Screen {
    typealias ViewControllerType = MainViewController
    
    static func presenter(controller: ViewControllerType, screenInput: MainInput, observer: AnyObserver<MainOutput>, uiInput: MainPresenterInput) -> (MainViewInput, [Disposable]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        var date: Date? = nil
        let hidden = uiInput.tap
            .flatMapLatest { Observable<Int>.timer(.seconds(3), scheduler: MainScheduler.instance).map { _ in true }.startWith(false) }.startWith(true)
        let dateText = uiInput.chooseDate
            .map { _ in date }
            .flatMap(use(Second.self, from: controller))
            .do(onNext: { date = $0 })
            .map(dateFormatter.string)
        let third = uiInput.third
            .bind(onNext: route(to: Third.self, with: controller.navigationController!))
        return (
            MainViewInput(
                hidden: hidden,
                dateText: dateText
            ),
            [third]
        )
    }
}
