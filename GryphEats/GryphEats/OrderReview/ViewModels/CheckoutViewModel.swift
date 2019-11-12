//
//  CheckoutViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-16.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Apollo
import Foundation
import Valet

// MARK: - CheckoutViewModel

class CheckoutViewModel: OrderSubmission {
    
    // MARK: Internal
    
    var paymentMethods: [PaymentMethod] {
        guard let rawData = Valet.keychain.string(forKey: Valet.Key.paymentMethods.rawValue),
            let paymentMethods = try? JSONDecoder().decode([PaymentMethod].self, from: Data(rawData.utf8)) else {
                return []
        }
        
        return paymentMethods
    }
}
