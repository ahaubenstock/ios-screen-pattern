//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//


import UIKit
import RxSwift

typealias ___VARIABLE_productName___Input = Void
typealias ___VARIABLE_productName___Output = Void

final class ___VARIABLE_productName___: Screen {
    typealias ViewControllerType = ___VARIABLE_productName___ViewController
    
    static func presenter(controller: ViewControllerType, screenInput: ___VARIABLE_productName___Input, observer: AnyObserver<___VARIABLE_productName___Output>, uiInput: ___VARIABLE_productName___PresenterInput) -> (___VARIABLE_productName___ViewInput, [Disposable]) {
        return (
            ___VARIABLE_productName___ViewInput(
            ),
            []
        )
    }
}
