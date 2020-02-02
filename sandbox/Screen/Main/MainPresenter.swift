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
        var date: Date? = nil
        let hidden = uiInput.tap
            .flatMapLatest { Observable<Int>.timer(.seconds(3), scheduler: MainScheduler.instance).map { _ in true }.startWith(false) }.startWith(true)
        let dateText = uiInput.chooseDate
            .flatMap { controller.use(Second.self, input: date) }
            .do(onNext: { date = $0 })
            .map { date -> String in
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                return dateFormatter.string(from: date)
            }
        return (
            MainViewInput(
                hidden: hidden,
                dateText: dateText
            ),
            []
        )
    }
}
