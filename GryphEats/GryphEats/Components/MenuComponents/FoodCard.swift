//
//  FoodCard.swift
//  GryphEats
//
//  Created by Owner on 11/9/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct FoodCard: View {
    
    init(foodItem: GraphFoodItem, onTap: @escaping () -> Void, onCommit: @escaping (String) -> Void) {
        self.foodItem = foodItem
        _isSelected = State(initialValue: foodItem.inStock)
        self.onTap = onTap
        self.onCommit = onCommit
    }
    
    // MARK: Internal
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            Button (action: {
                self.onTap()//{(self.price:String) in }
                self.isSelected.toggle()
            }) {
                HStack(alignment: .top) {
                    Rectangle()
                        .fill(isSelected ? Color.guelphRed(for: colorScheme) : Color.lightGray(for: colorScheme))
                        .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(5)
                        .shadow(radius: 2)
                    Text(foodItem.name)
                        .foregroundColor(Color.black)
                        .font(.system(size: 26, weight: .semibold))
                        .padding(.leading)
                    Spacer()
                }
            }.padding(.bottom)
            CustomTextField(header: "Price", subtitle: "", placeholder: String(foodItem.price), text: self.$price, editingChanged: { isChanged in
                if (isChanged) {
                    self.onCommit(self.price)
                }
            }, commit: {
                self.onCommit(self.price)
            }, headerFontSize: 22, textFieldFontSize: 24)
        }.padding(.all)
            .contentShape(Rectangle())
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 2)
            .opacity(isSelected ? 1.0 : 0.6)
            .padding(.all)
    }
    
    // MARK: Private
    
    @State private var isSelected: Bool
    @State private var price: String = ""
    
    private let onCommit: (String) -> Void
    private let onTap: () -> Void
    private let foodItem: GraphFoodItem
}
