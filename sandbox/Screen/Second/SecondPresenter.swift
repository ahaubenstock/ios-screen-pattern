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
    
    static func presenter(controller: ViewControllerType, subject: PublishSubject<SecondOutput>, input: SecondPresenterInput) -> SecondViewInput {
        _ = input.back
            .bind(onNext: {
                subject.onCompleted()
            })
        _ = input.date
            .bind(to: subject)
        return SecondViewInput(
        )
    }
}
