//
//  AddPaymentView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-17.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import Valet

// MARK: - AddPaymentView

struct AddPaymentView: View, Dismissable {
    
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
            
            Picker("Payment Types", selection: $paymentType) {
                ForEach(0 ..< PaymentType.allCases.count) { index in
                    Text(PaymentType.allCases[index].asString).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
            
            if paymentType == 0 {
                AddCreditCardView { paymentMethod in
                    self.save(paymentMethod)
                }
            } else {
                AddMealPlanView { paymentMethod in
                    self.save(paymentMethod)
                }
            }
            
        }.background(Rectangle()
            .fill(Color.lightGray)
            .edgesIgnoringSafeArea(.all))
            .dismissKeyboardOnTapGesture()
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Private
    
    @State private var paymentType: Int = 0
    
    private func save(_ paymentMethod: PaymentMethod) {
        let rawData = Valet.keychain.string(forKey: Valet.Keys.paymentMethods.rawValue)
        
        var paymentMethods = (try? JSONDecoder().decode(
            [PaymentMethod].self, from: Data(rawData?.utf8 ?? "".utf8))) ?? []
        
        paymentMethods.append(paymentMethod)
        
        if let encodedData = try? JSONEncoder().encode(paymentMethods) {
            Valet.keychain.set(object: encodedData, forKey: Valet.Keys.paymentMethods.rawValue)
        }
        
        dismiss()
    }
}

struct AddPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentView()
    }
}
