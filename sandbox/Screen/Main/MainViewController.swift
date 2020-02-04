//
//  MainViewController.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//	Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct MainPresenterInput {
    let tap: Observable<Void>
    let chooseDate: Observable<Void>
    let third: Observable<Void>
}

struct MainViewInput {
    let hidden: Observable<Bool>
    let dateText: Observable<String>
}

final class MainViewController: UIViewController, ScreenViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var chooseDateButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var goToThirdButton: UIButton!
    
    lazy private(set) var presenterInput = MainPresenterInput(
        tap: button.rx.tap.asObservable(),
        chooseDate: chooseDateButton.rx.tap.asObservable(),
        third: goToThirdButton.rx.tap.asObservable()
    )
	
    func bind(input: MainViewInput) -> [Disposable] {
        return [
            input.hidden.bind(to: label.rx.isHidden),
            input.dateText.bind(to: dateLabel.rx.text)
        ]
    }
}
