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
            if studentNumber.count > 7 {
                studentNumber = oldValue
            }
        }
    }
    
    var isStudentNumberValid: Bool {
        return studentNumber.count == 7
    }
    
    var isAllInfoValid: Bool {
        return !studentName.isEmpty && isStudentNumberValid
    }
}
