//
//  SecondPresenter.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift

typealias SecondOutput = Date

final class Second: Screen {
    typealias ViewControllerType = SecondViewController
    
    static func presenter(controller: ViewControllerType, observer: AnyObserver<SecondOutput>, input: SecondPresenterInput) -> (SecondViewInput, [Disposable]) {
        let back = input.back
            .bind(onNext: observer.onCompleted)
        let date = input.date
            .bind(onNext: observer.onNext)
        return (
            SecondViewInput(
            ),
            [back, date]
        )
    }
}
