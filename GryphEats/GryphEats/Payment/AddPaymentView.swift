//
//  AddPaymentView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-17.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - AddPaymentView

struct AddPaymentView: View {
    
    // MARK: PaymentType
    
    private enum PaymentType: Int, CaseIterable {
        case credit
        case studentCard
        
        var asString: String {
            switch self {
            case .credit:
                return "Credit Card"
            case .studentCard:
                return "Student Card"
            }
        }
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Add Payment Method").font(.headline)
                Spacer()
            }.padding(.top)
            
            Picker(selection: $paymentType, label: Text("")) {
                ForEach(0 ..< PaymentType.allCases.count) { index in
                    Text(PaymentType.allCases[index].asString).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
            
            CreditCardInfoTextField(
                header: "Cardholder Name",
                placeholder: "Cardholder Name",
                text: $viewModel.cardHolderName)
                .padding(.bottom)
            
            Group {
                CreditCardInfoTextField(
                    displayMode: .creditCardNumber,
                    subtitleDisplayMode: viewModel.isCreditCardNumberValid ?
                        .hidden : .visible(text: "Invalid credit card number. Only Visa and Mastercard are accepted."),
                    header: "Card Number",
                    placeholder: "Enter card number",
                    text: $viewModel.creditCardNumber)
                    .padding(.bottom)
                
                HStack(alignment: .top) {
                    CreditCardInfoTextField(
                        displayMode: .question(info: viewModel.expiryInfo),
                        subtitleDisplayMode: viewModel.isExpiryValid ?
                            .hidden : .visible(text: "Invalid expiry date"),
                        header: "Expiry",
                        placeholder: "MMDD",
                        text: $viewModel.expiryDate)
                    CreditCardInfoTextField(
                        displayMode: .question(info: viewModel.cvvInfo),
                        subtitleDisplayMode: viewModel.isCvvValid ?
                        .hidden : .visible(text: "Invalid CVV"),
                        header: "CVV",
                        placeholder: "CVV",
                        text: $viewModel.cvv)
                }
            }.keyboardType(.numberPad)
            
            Spacer()
            
            HStack {
                Spacer()
                Text("Your credit card information will be stored only on this device within the Keychain. Only this app will be able to access the data.")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .padding()
                Spacer()
            }
            
            ActionButton(
                text: "Save",
                backgroundColor: .guelphRed,
                foregroundColor: .white,
                isDisabled: !viewModel.isAllInfoValid) {
                    self.dismiss(self.presentationMode)
            }.padding(.bottom)
        }.background(Rectangle()
            .fill(Color.lightGray)
            .edgesIgnoringSafeArea(.all))
            .dismissKeyboardOnTapGesture()
    }
    
    // MARK: Private
    
    @State private var paymentType: Int = 0
    @ObservedObject private var viewModel = AddPaymentViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
}

struct AddPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentView()
    }
}
