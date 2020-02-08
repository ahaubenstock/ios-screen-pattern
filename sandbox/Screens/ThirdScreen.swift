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

final class ThirdScreen: Screen {
    static func addLogic(to component: ThirdComponent, input: Void, observer: AnyObserver<Void>) -> [Disposable] {
        let back = component.backButton.rx.tap
            .bind(onNext: observer.onCompleted)
        return [
            back
        ]
    }
}
