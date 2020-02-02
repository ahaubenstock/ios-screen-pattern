//
//  AppDelegate.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 1/27/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: Main.create())
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        #if DEBUG
        _ = Observable<Int>.interval(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { _ in RxSwift.Resources.total }
            .distinctUntilChanged()
            .subscribe(onNext: { print("♦️ Resource count \($0)") })
        #endif
        return true
    }
}

