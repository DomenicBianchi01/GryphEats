//
//  AddMealPlanView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-21.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - AddMealPlanView

struct AddMealPlanView: View {
    
    // MARK: Lifecycle
    
    init(onSave: @escaping (PaymentMethod) -> Void) {
        self.onSave = onSave
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
            PaymentInfoTextField(
                header: "Student Name",
                placeholder: "Student Name",
                text: $viewModel.studentName)
                .padding(.bottom)
            
            PaymentInfoTextField(
                subtitleDisplayMode: viewModel.isStudentNumberValid ?
                    .hidden : .visible(text: "Invalid student number. Student numbers contain 7 digits."),
                header: "Student Number",
                placeholder: "Student Number",
                text: $viewModel.studentNumber)
                .keyboardType(.numberPad)
                .padding(.bottom)
            
            Spacer()
            
            Text("Your student card information will be stored only on this device within the Keychain. Only this app will be able to access the data.")
                .multilineTextAlignment(.center)
                .font(.caption)
                .padding()
            
            ActionButton(
                text: "Save",
                backgroundColor: .guelphRed(for: colorScheme),
                foregroundColor: .white,
                isDisabled: !viewModel.isAllInfoValid) {
                    guard let paymentMethod = self.viewModel.createPaymentMethod() else {
                        return
                    }
                    
                    self.onSave(paymentMethod)
            }.padding(.bottom)
        }
    }
    
    // MARK: Private
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @ObservedObject private var viewModel = AddMealPlanViewModel()
    private let onSave: (PaymentMethod) -> Void
    
}

struct AddMealPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealPlanView { _ in }
    }
}
