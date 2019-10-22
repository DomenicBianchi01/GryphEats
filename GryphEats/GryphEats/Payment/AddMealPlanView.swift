//
//  AddMealPlanView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-21.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - AddMealPlanView

struct AddMealPlanView: View, Dismissable {
    
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
                backgroundColor: .guelphRed,
                foregroundColor: .white,
                isDisabled: !viewModel.isAllInfoValid) {
                    self.dismiss()
            }.padding(.bottom)
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Private
    
    @ObservedObject private var viewModel = AddMealPlanViewModel()
    
}

struct AddMealPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealPlanView()
    }
}
