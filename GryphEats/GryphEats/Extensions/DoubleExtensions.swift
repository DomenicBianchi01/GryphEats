//
//  DoubleExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - Double

extension Double {
    
    // MARK: Internal
    
    var asDollarString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.roundingMode = .up

        return "$" + String(describing: formatter.string(from: NSNumber(value: self)) ?? "Unknown")
    }
}
