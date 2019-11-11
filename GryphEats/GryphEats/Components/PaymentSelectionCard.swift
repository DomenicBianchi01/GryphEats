//
//  PaymentSelectionCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-16.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - PaymentSelectionCard

struct PaymentSelectionCard: View {
    
    // MARK: Lifecycle
    
    init(paymentMethod: PaymentMethod, isSelected: Bool = false, tapAction: @escaping () -> Void) {
        self.paymentMethod = paymentMethod
        self.isSelected = isSelected
        self.tapAction = tapAction
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    Text(accountNumber)
                    Text(paymentMethod.accountName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    studentMealPlanContent
                }
                Spacer()
            }.padding(.all, 10)
        }.font(.system(size: 14))
            .background(Color.cardBackground(for: colorScheme))
            .cornerRadius(5)
            .padding([.horizontal, .top], 10)
            .shadow(color: isSelected ? .guelphRed(for: colorScheme) : .secondary, radius: 2)
            .onTapGesture {
                self.tapAction()
        }
    }
    
    // MARK: Private
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    private let paymentMethod: PaymentMethod
    private let tapAction: () -> Void
    private let isSelected: Bool
    
    private var imageName: String {
        switch paymentMethod.cardType {
        case .visa:
            return "visaLogo"
        case .mastercard:
            return "mastercardLogo"
        case .student:
            return "hospitalityLogo"
        }
    }
    
    private var accountNumber: String {
        if case .student = paymentMethod.cardType {
            return String(paymentMethod.accountNumber)
        }
        
        return "•••• " + paymentMethod.lastFourDigits
    }
    
    private var studentMealPlanContent: Text? {
        if case let .student(mealPlanType) = paymentMethod.cardType {
            return Text(mealPlanType == .onCampus ? "On-Campus Meal Plan" : "Ultra Meal Plan")
                .font(.caption)
                .italic()
                .foregroundColor(.secondary)
        }
        
        return nil
    }
}

struct PaymentSelectionCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            PaymentSelectionCard(
                paymentMethod: PaymentMethod(
                    cardType: .visa,
                    accountName: "Domenic Bianchi",
                    accountNumber: 123456789)) {}
            PaymentSelectionCard(
                paymentMethod: PaymentMethod(
                    cardType: .mastercard,
                    accountName: "Domenic Bianchi",
                    accountNumber: 123456789),
                isSelected: true) {}
            PaymentSelectionCard(
                paymentMethod: PaymentMethod(
                    cardType: .student(mealPlanType: .onCampus),
                    accountName: "Domenic Bianchi",
                    accountNumber: 0921557)) {}
        }
    }
}
