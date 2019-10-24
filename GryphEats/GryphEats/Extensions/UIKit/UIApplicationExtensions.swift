//
//  UIApplicationExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-24.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import UIKit

// MARK: - UIApplication

extension UIApplication {
    
    var firstKeyWindow: UIWindow? {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first
    }
}
