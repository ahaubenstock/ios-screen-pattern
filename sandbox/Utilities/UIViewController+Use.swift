//
//  UIViewController+Use.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController {
    func use<T: Screen>(_ screen: T.Type) -> Observable<T.Output> {
        let (vc, output) = screen.create()
        present(vc, animated: true, completion: nil)
        return output
            .do(onCompleted: { vc.dismiss(animated: true, completion: nil) })
    }
}
