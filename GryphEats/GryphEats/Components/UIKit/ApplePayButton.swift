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

// SwiftUI doesn't seem to know how to display `PKPaymentAuthorizationViewController` correctly. I've left this code
// here for now just so I could possibly work on this in the future.
@available(*, unavailable)
struct ApplePayViewController: UIViewControllerRepresentable {
    
    // MARK: Lifeycle
    
    init(cart: Cart, completion: @escaping (Bool) -> Void) {
        self.cart = cart
        self.completion = completion
    }
    
    // MARK: Internal

    func makeUIViewController(context: Context) -> PKPaymentAuthorizationViewController {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.ca.uofg.hospitality"
        request.supportedNetworks = [.visa, .masterCard]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "CA"
        request.currencyCode = "CAD"
        
        let items = cart.items.map {
            PKPaymentSummaryItem(
                label: $0.foodItem.name,
                amount: NSDecimalNumber(value: $0.foodItem.price))
        }
        
        request.paymentSummaryItems = items + [
            PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(value: cart.tax())),
            PKPaymentSummaryItem(label: "GryphEats", amount: NSDecimalNumber(value: cart.total()))
        ]
        
        let paymentViewController = PKPaymentAuthorizationViewController(paymentRequest: request)!
        paymentViewController.delegate = context.coordinator
        
        return paymentViewController
    }

    func updateUIViewController(_ uiViewController: PKPaymentAuthorizationViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewController: self, completion: completion)
    }
    
    // MARK: Private
    
    private let cart: Cart
    private let completion: (Bool) -> Void
    
    // MARK: - Coordinator

    class Coordinator: NSObject, PKPaymentAuthorizationViewControllerDelegate {
        
        // MARK: Lifecycle
        
        init(viewController: ApplePayViewController, completion: @escaping (Bool) -> Void) {
            self.completion = completion
        }
        
        // MARK: Internal
        
        func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
            controller.dismiss(animated: true) {
                if self.paymentAuthorized {
                    self.completion(true)
                }
            }
        }
        
        func paymentAuthorizationViewController(
            _ controller: PKPaymentAuthorizationViewController,
            didAuthorizePayment payment: PKPayment,
            handler completion: @escaping (PKPaymentAuthorizationResult) -> Void)
        {
            paymentAuthorized = true
            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        }
        
        // MARK: Private
        
        private var paymentAuthorized = false
        private let completion: ((Bool) -> Void)
        
    }
}
