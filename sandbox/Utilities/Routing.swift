//
//  Routing.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/3/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift

func route<T: Screen>(to screen: T.Type, with navigation: UINavigationController) -> (T.Input) -> Void where T.Output == Void {
    return { [unowned navigation] input in
        let (vc, output) = screen.create(input: input)
        DispatchQueue.main.async {
            navigation.pushViewController(vc, animated: true)
            _ = output
                .observeOn(MainScheduler.instance)
                .subscribe(onCompleted: { navigation.popViewController(animated: true) })
        }
    }
}

func use<T: Screen>(_ screen: T.Type, from controller: UIViewController) -> (T.Input) -> Observable<T.Output> {
    return { [unowned controller] input in
        let (vc, output) = screen.create(input: input)
        let shared = output
            .share()
            .replayAll()
        DispatchQueue.main.async {
            controller.present(vc, animated: true, completion: nil)
            _ = output
                .observeOn(MainScheduler.instance)
                .subscribe(onCompleted: { vc.dismiss(animated: true, completion: nil) })
        }
        return shared
    }
}
