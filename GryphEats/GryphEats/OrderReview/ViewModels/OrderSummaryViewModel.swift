//
//  OrderSummaryViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-11.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import PassKit

// MARK: - OrderSummaryViewModel

class OrderSummaryViewModel: OrderSubmission {
    
    // MARK: Internal
    
    func promptApplePay(for cart: Cart, completion: @escaping (Bool) -> Void) -> PKPaymentAuthorizationViewController? {
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
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController?.delegate = self
        
        self.applePayController = applePayController
        self.completion = completion
        
        return applePayController
    }
    
    weak var applePayController: PKPaymentAuthorizationViewController?
    
    // MARK: Private
    
    private var completion: ((Bool) -> Void)?
    
}

// MARK: PKPaymentAuthorizationViewControllerDelegate

extension OrderSummaryViewModel: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        applePayController?.dismiss(animated: true) {
            self.completion?(true)
        }
    }
    
    func paymentAuthorizationViewController(
        _ controller: PKPaymentAuthorizationViewController,
        didAuthorizePayment payment: PKPayment,
        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void)
    {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}
