//
//  EnvironmentExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import UIKit
import SwiftUI

//https://stackoverflow.com/a/56880640

struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: ViewControllerHolder {
        get {
            return self[ViewControllerKey.self]
        }
        set {
            self[ViewControllerKey.self] = newValue
        }
    }
}
