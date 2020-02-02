//
//  HasStoryboard.swift
//  sandbox
//
//  Created by Adam E. Haubenstock on 2/1/20.
//  Copyright © 2020 Adam E. Haubenstock. All rights reserved.
//

import UIKit

protocol HasStoryboard: UIViewController {
    static func fromStoryboard() -> Self
}

extension HasStoryboard {
    static func fromStoryboard() -> Self {
        return UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() as! Self
    }
}
