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
            
            Picker("Payment Types", selection: $paymentType) {
                ForEach(0 ..< PaymentType.allCases.count) { index in
                    Text(PaymentType.allCases[index].asString).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
            
            if paymentType == 0 {
                AddCreditCardView()
            } else {
                AddMealPlanView()
            }
            
        }.background(Rectangle()
            .fill(Color.lightGray)
            .edgesIgnoringSafeArea(.all))
            .dismissKeyboardOnTapGesture()
    }
    
    // MARK: Private
    
    @State private var paymentType: Int = 0
    
}

struct AddPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentView()
    }
}
