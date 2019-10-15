//
//  PriceSummaryCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - PriceSummaryCard

struct PriceSummaryCard: View {
    
    // MARK: Internal
    
    var body: some View {
        let subtotal = cart.subtotal()
        let tax = cart.tax()
        
        return VStack {
            HStack {
                Text("Subtotal").bold()
                Spacer()
                Text(subtotal.asDollarString)
            }.padding(.top, 20)
                .padding(.bottom, 5)
                .padding(.horizontal)
            
            discountRow(type: .onCampus, amount: (subtotal - cart.subtotal(for: .onCampus)).asDollarString)
            discountRow(type: .offCampus, amount: (subtotal - cart.subtotal(for: .offCampus)).asDollarString)

            HStack {
                Text("Tax (13% HST)").bold()
                Spacer()
                Text(tax.asDollarString)
            }.padding(.vertical, 5)
                .padding(.horizontal)
            
            discountRow(type: .onCampusTax, amount: (tax - cart.tax(for: .onCampus)).asDollarString)
            discountRow(type: .offCampusTax, amount: (tax - cart.tax(for: .offCampus)).asDollarString)
            
            HStack {
                Text("Total").bold()
                Spacer()
                Text(cart.total().asDollarString)
            }.padding(.vertical, 5)
                .padding(.horizontal)
                .foregroundColor(.guelphRed)
            
            // SwiftUI Bug: Had to wrap these rows in a Group for some reason
            Group {
                discountRow(type: .onCampusTotal, amount: cart.total(for: .onCampus).asDollarString)
                discountRow(type: .offCampusTotal, amount: cart.total(for: .offCampus).asDollarString)
                    .padding(.bottom, 10)
            }
            
            Text("Meal Plan discounts are only valid if you pay with your student card.")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            ActionButton(text: "Continue") {
                withAnimation {
                    //self.state.state = .checkout
                }
            }.padding(.top, 10)
            .padding(.bottom, 20)
        }.font(.system(size: 14))
            .background(Color.white)
            .cornerRadius(5)
            .padding(.all, 10)
            .shadow(radius: 2)
    }
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart
    
    private func discountRow(type: DiscountType, amount: String) -> some View {
        HStack {
            Text(type.rawValue)
                .padding(.leading, 20)
            Spacer()
            
            if type == .onCampusTotal || type == .offCampusTotal {
                Text(amount).foregroundColor(.guelphRed)
            } else {
                Text("-" + amount)
            }
        }.font(.system(size: 10))
            .padding(.horizontal)
            .padding(.bottom, 10)
            .foregroundColor(.secondary)
    }
    
    private enum DiscountType: String {
        case onCampus = "With On-Campus Meal Plan (30% discount)"
        case onCampusTax = "With On-Campus Meal Plan (No Tax)"
        case onCampusTotal = "With On-Campus Meal Plan"
        
        case offCampus = "With Ultra Meal Plan (10% discount)"
        case offCampusTax = "With Ultra Meal Plan (5% tax discount)"
        case offCampusTotal = "With Ultra Meal Plan"
    }
}

struct PriceSummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        PriceSummaryCard().environmentObject(Cart())
    }
}
