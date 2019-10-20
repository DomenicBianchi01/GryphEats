//
//  CheckoutViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-16.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Valet

// MARK: - CheckoutViewModel

class CheckoutViewModel {
    
    // MARK: Internal

    var paymentMethods: [PaymentMethod] {
        return [
            PaymentMethod(
                cardType: .visa,
                accountName: "Domenic Bianchi",
                accountNumber: 1234567894),
            PaymentMethod(
                cardType: .mastercard,
                accountName: "Domenic Bianchi",
                accountNumber: 123456789),
            PaymentMethod(
                cardType: .student(mealPlanType: .onCampus),
                accountName: "Domenic Bianchi",
                accountNumber: 1234567893),
            PaymentMethod(
            cardType: .student(mealPlanType: .ultra),
            accountName: "Domenic Bianchi",
            accountNumber: 1234567893)
        ]
    }
}
