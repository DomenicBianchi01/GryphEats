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

// MARK: - ViewControllerHolder

struct ViewControllerHolder {
    weak var value: UIViewController?
}

// MARK: - ViewControllerKey

struct ViewControllerKey: EnvironmentKey {
    
    // MARK: Internal
    
    static var defaultValue: ViewControllerHolder {
        ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

// MARK: - EnvironmentValues

extension EnvironmentValues {
    
    // MARK: Internal
    
    var viewController: ViewControllerHolder {
        get {
            self[ViewControllerKey.self]
        }
        set {
            self[ViewControllerKey.self] = newValue
        }
    }
}
