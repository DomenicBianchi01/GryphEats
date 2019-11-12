//
//  CardProvider.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-22.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: CardProvider

enum CardProvider: Int {
    case visa = 4
    case mastercard = 5
    
    // MARK: Internal
    
    var imageName: String {
        switch self {
        case .visa:
            return "visaLogo"
        case .mastercard:
            return "mastercardLogo"
        }
    }
}
