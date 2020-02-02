//
//  SecondPresenter.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift

typealias SecondInput = Date?
typealias SecondOutput = Date

final class Second: Screen {
    typealias ViewControllerType = SecondViewController
    
    static func presenter(controller: ViewControllerType, screenInput: SecondInput, observer: AnyObserver<SecondOutput>, uiInput: SecondPresenterInput) -> (SecondViewInput, [Disposable]) {
        let back = uiInput.back
            .bind(onNext: observer.onCompleted)
        let date = uiInput.date
            .bind(onNext: observer.onNext)
        return (
            SecondViewInput(
                start: screenInput ?? Date()
            ),
            [back, date]
        )
    }
}
