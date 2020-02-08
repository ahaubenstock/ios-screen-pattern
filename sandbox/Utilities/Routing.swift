//
//  Routing.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/3/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift

func route<T: Screen>(to screen: T.Type, from component: Component) -> (T.Input) -> Void where T.Output == Void {
    return { [unowned component] input in
        let navigation = component.navigationController!
        let (_component, output) = screen.create(input: input)
        DispatchQueue.main.async {
            navigation.pushViewController(_component, animated: true)
            _ = output
                .observeOn(MainScheduler.instance)
                .subscribe(onCompleted: { navigation.popViewController(animated: true) })
        }
    }
}

func use<T: Screen>(_ screen: T.Type, from component: Component) -> (T.Input) -> Observable<T.Output> {
    return { [unowned component] input in
        let (_component, output) = screen.create(input: input)
        let shared = output
        DispatchQueue.main.async {
            component.present(_component, animated: true, completion: nil)
            _ = output
                .observeOn(MainScheduler.instance)
                .subscribe(onCompleted: { _component.dismiss(animated: true, completion: nil) })
        }
        return shared
    }
}
