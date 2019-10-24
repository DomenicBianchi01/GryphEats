//
//  UIDeviceExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-07.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import UIKit

// MARK: - UIDevice

extension UIDevice {
    
    // MARK: Internal
    
    var isPad: Bool {
        userInterfaceIdiom == .pad
    }
    
    var hasBottomSafeArea: Bool {
        UIApplication.shared.firstKeyWindow?.safeAreaInsets.bottom ?? 0 > 0
    }
}
