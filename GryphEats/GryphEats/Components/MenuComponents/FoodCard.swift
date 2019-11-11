//
//  FoodCard.swift
//  GryphEats
//
//  Created by Owner on 11/9/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct FoodCard: View {
    init(itemName: String, currentPrice: String, onTap: @escaping () -> Void) {
        self.itemName = itemName
        self.currentPrice = currentPrice
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            Button (action: {
                self.onTap()
                self.isSelected.toggle()
            }) {
                HStack(alignment: .top) {
                    Rectangle()
                        .fill(isSelected ? Color.guelphRed(for: colorScheme) : Color.lightGray(for: colorScheme))
                        .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(5)
                        .shadow(radius: 2)
                    Text(itemName)
                        .foregroundColor(Color.black)
                        .font(.system(size: 26, weight: .semibold))
                        .padding(.leading)
                    Spacer()
                }
            }.padding(.bottom)
            CustomTextField(header: "Price", placeholder: currentPrice, text: self.$price, headerFontSize: 22, textFieldFontSize: 24)
        }.padding(.all)
            .contentShape(Rectangle())
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 2)
            .opacity(isSelected ? 1.0 : 0.6)
            .padding(.all)
    }
    
    // MARK: Private
    
    @State private var isSelected: Bool = false
    @State private var price: String = ""
    
    private let onTap: () -> Void
    private let itemName: String
    //    private let frameSize = CGSize(width: 150, height: 200)
    private let currentPrice: String
}
