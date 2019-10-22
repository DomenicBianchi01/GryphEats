//
//  AddCreditCardView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-21.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - AddCreditCardView

struct AddCreditCardView: View, Dismissable {
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
            PaymentInfoTextField(
                header: "Cardholder Name",
                placeholder: "Cardholder Name",
                text: $viewModel.cardHolderName)
                .padding(.bottom)
            
            Group {
                PaymentInfoTextField(
                    displayMode: .creditCardNumber,
                    subtitleDisplayMode: viewModel.isCreditCardNumberValid ?
                        .hidden : .visible(text: "Invalid credit card number. Only Visa and Mastercard are accepted."),
                    header: "Card Number",
                    placeholder: "Enter card number",
                    text: $viewModel.creditCardNumber)
                    .padding(.bottom)
                
                HStack(alignment: .top) {
                    PaymentInfoTextField(
                        displayMode: .question(info: viewModel.expiryInfo),
                        subtitleDisplayMode: viewModel.isExpiryValid ?
                            .hidden : .visible(text: "Invalid expiry date"),
                        header: "Expiry",
                        placeholder: "MMDD",
                        text: $viewModel.expiryDate)
                    PaymentInfoTextField(
                        displayMode: .question(info: viewModel.cvvInfo),
                        subtitleDisplayMode: viewModel.isCvvValid ?
                            .hidden : .visible(text: "Invalid CVV"),
                        header: "CVV",
                        placeholder: "CVV",
                        text: $viewModel.cvv)
                }
            }.keyboardType(.numberPad)
            
            Spacer()
            
            Text("Your credit card information will be stored only on this device within the Keychain. Only this app will be able to access the data.")
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
    
    @ObservedObject private var viewModel = AddCreditCardViewModel()
    
}

struct AddCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCreditCardView()
    }
}
