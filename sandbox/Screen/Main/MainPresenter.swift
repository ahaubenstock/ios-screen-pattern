//
//  MainPresenter.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//	Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift

typealias MainOutput = Void

final class Main: Screen {
    typealias ViewControllerType = MainViewController
    
    static func presenter(controller: ViewControllerType, subject: PublishSubject<MainOutput>, input: MainPresenterInput) -> MainViewInput {
        let hidden = input.tap
            .flatMapLatest { Observable<Int>.timer(.seconds(3), scheduler: MainScheduler.instance).map { _ in true }.startWith(false) }.startWith(true)
        let dateText = input.chooseDate
            .flatMap { controller.use(Second.self) }
            .map { date -> String in
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                return dateFormatter.string(from: date)
            }
        return MainViewInput(
            hidden: hidden,
            dateText: dateText
        )
    }
}
