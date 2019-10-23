//
//  AddCreditCardViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-18.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - AddCreditCardViewModel

class AddCreditCardViewModel: ObservableObject {
    
    // MARK: Internal
    
    @Published var cardHolderName: String = ""
    
    @Published var creditCardNumber: String = "" {
        didSet {
            if creditCardNumber.count > 16 || (Int(creditCardNumber) == nil && creditCardNumber.count != 0) {
                creditCardNumber = oldValue
            }
        }
    }
    
    @Published var expiryDate: String = "" {
        didSet {
            if expiryDate.count > 4 || (Int(expiryDate) == nil && expiryDate.count != 0) {
                expiryDate = oldValue
            }
        }
    }
    
    @Published var cvv: String = "" {
        didSet {
            if cvv.count > 3 || (Int(cvv) == nil && cvv.count != 0) {
                cvv = oldValue
            }
        }
    }
    
    let cvvInfo = "You should be able to find this three digit code on the back of your card"
    let expiryInfo = "You should be able to find this date on the front of your card, under the card number."
    
    var isCreditCardNumberValid: Bool {
        // For the sake of this project, we won't be checking if the credit card number is valid in reality
        (creditCardNumber.first == "4" || creditCardNumber.first == "5") && creditCardNumber.count == 16
    }
    
    var isExpiryValid: Bool {
        if expiryDate.count == 4 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMyy"
            
            guard let enteredDate = dateFormatter.date(from: expiryDate) else {
                return false
            }
            
            return enteredDate.compare(Date()) != .orderedAscending
        }
        
        return false
    }
    
    var isCvvValid: Bool {
        cvv.count == 3
    }
    
    var isAllInfoValid: Bool {
        !cardHolderName.isEmpty && isCreditCardNumberValid && isExpiryValid && isCvvValid
    }
    
    func createPaymentMethod() -> PaymentMethod? {
        guard let accountNumber = Int(creditCardNumber),
            let firstDigit = creditCardNumber.first,
            let firstDigitAsInt = Int(String(firstDigit)),
            let cardProvider = CardProvider(rawValue: firstDigitAsInt) else
        {
            return nil
        }
        
        return PaymentMethod(
            cardType: cardProvider == .visa ? .visa : .mastercard,
            accountName: cardHolderName,
            accountNumber: accountNumber)
    }
}
