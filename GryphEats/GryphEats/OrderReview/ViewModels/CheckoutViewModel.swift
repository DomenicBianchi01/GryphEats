//
//  CheckoutViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-16.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import Valet

// MARK: - CheckoutViewModel

class CheckoutViewModel {

    // MARK: Lifecycle
    
    init(paymentOption: PaymentOption) {
        self.paymentOption = paymentOption
    }
    
    // MARK: Internal
    
    let paymentOption: PaymentOption

}
