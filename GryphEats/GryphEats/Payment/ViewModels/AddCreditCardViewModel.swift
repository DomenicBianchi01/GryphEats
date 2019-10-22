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
            if creditCardNumber.count > 16 {
                creditCardNumber = oldValue
            }
        }
    }

    @Published var expiryDate: String = "" {
        didSet {
            if expiryDate.count > 4 {
                expiryDate = oldValue
            }
        }
    }

    @Published var cvv: String = "" {
        didSet {
            if cvv.count > 3 {
                cvv = oldValue
            }
        }
    }
    
    let cvvInfo = "You should be able to find this three digit code on the back of your card"
    let expiryInfo = "You should be able to find this date on the front of your card, under the card number."
    
    var isCreditCardNumberValid: Bool {
        // For the sake of this project, we won't be checking if the credit card number is valid in reality
        return (creditCardNumber.first == "4" || creditCardNumber.first == "5") && creditCardNumber.count == 16
    }
    
    var isExpiryValid: Bool {
        return expiryDate.count == 4
    }
    
    var isCvvValid: Bool {
        return cvv.count == 3
    }
    
    var isAllInfoValid: Bool {
        return !cardHolderName.isEmpty && isCreditCardNumberValid && isExpiryValid && isCvvValid
    }
}
