//
//  AddMealPlanViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-21.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - AddMealPlanViewModel

class AddMealPlanViewModel: ObservableObject {
    
    // MARK: Internal
    
    @Published var studentName: String = ""
    
    @Published var studentNumber: String = "" {
        didSet {
            if studentNumber.count > 7 || (Int(studentNumber) == nil && studentNumber.count != 0) {
                studentNumber = oldValue
            }
        }
    }
    
    var isStudentNumberValid: Bool {
        studentNumber.count == 7
    }
    
    var isAllInfoValid: Bool {
        !studentName.isEmpty && isStudentNumberValid
    }
    
    func createPaymentMethod() -> PaymentMethod? {
        guard let accountNumber = Int(studentNumber) else {
            return nil
        }
        
        return PaymentMethod(
            cardType: .student(mealPlanType: .onCampus), //TODO: Meal plan type
            accountName: studentName,
            accountNumber: accountNumber)
    }
}
