//
//  SecondViewController.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//	Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct SecondPresenterInput {
    let back: Observable<Void>
    let date: Observable<Date>
}

struct SecondViewInput {
}

final class SecondViewController: UIViewController, ScreenViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    lazy private(set) var presenterInput = SecondPresenterInput(
        back: backButton.rx.tap.asObservable(),
        date: datePicker.rx.date.asObservable()
    )
	
    func bind(input: SecondViewInput) -> [Disposable] {
        return [
        ]
    }
}
