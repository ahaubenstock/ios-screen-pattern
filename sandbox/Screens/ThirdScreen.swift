//
//  ThirdScreen.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/7/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ThirdScreen: Flow {
    static func addLogic(to component: ThirdComponent, input: Void, observer: AnyObserver<String>) -> [Disposable] {
        let cancel = component.cancelButton.rx.tap
            .bind(onNext: observer.onCompleted)
        let choice = component.goToFourthButton.rx.tap
            .flatMap(flow(to: FourthScreen.self, from: component))
            .bind(onNext: {
                observer.onNext($0)
                observer.onCompleted()
            })
        return [
            cancel,
            choice
        ]
    }
}
