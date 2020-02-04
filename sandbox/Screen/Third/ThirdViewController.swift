//
//  ThirdViewController.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/3/20.
//	Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct ThirdPresenterInput {
    let back: Observable<Void>
}

struct ThirdViewInput {
}

final class ThirdViewController: UIViewController, ScreenViewController {
    @IBOutlet weak var backButton: UIButton!
    
    lazy private(set) var presenterInput = ThirdPresenterInput(
        back: backButton.rx.tap.asObservable()
    )
	
    func bind(input: ThirdViewInput) -> [Disposable] {
        return [
        ]
    }
}
