//
//  ApplePayButton.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import PassKit
import SwiftUI
import UIKit

// MARK: - ApplePayButton

/// `PKPaymentButton` bridged over to SwiftUI
// The Apple Pay button does not work on Catalyst
@available(macCatalyst, unavailable)
struct ApplePayButton: UIViewRepresentable {
    
    // MARK: Internal
    
    func makeUIView(context: UIViewRepresentableContext<ApplePayButton>) -> UIButton {
        PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<ApplePayButton>) {
    }
}
