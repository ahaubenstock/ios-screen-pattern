//
//  ThirdPresenter.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/3/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//


import UIKit
import RxSwift

typealias ThirdInput = Void
typealias ThirdOutput = Void

final class Third: Screen {
    typealias ViewControllerType = ThirdViewController
    
    static func presenter(controller: ViewControllerType, screenInput: ThirdInput, observer: AnyObserver<ThirdOutput>, uiInput: ThirdPresenterInput) -> (ThirdViewInput, [Disposable]) {
        let back = uiInput.back
            .bind(onNext: observer.onCompleted)
        return (
            ThirdViewInput(
            ),
            [back]
        )
    }
}
