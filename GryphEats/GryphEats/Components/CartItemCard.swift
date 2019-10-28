//
//  CartItemCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-14.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CartItemCard

struct CartItemCard: View {
    
    // MARK: Lifecycle
    
    init(item: GraphFoodItem, editAction: @escaping () -> Void, deleteAction: @escaping () -> Void) {
        self.item = item
        self.editAction = editAction
        self.deleteAction = deleteAction
    }
    
    // MARK: Internal
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.displayName ?? "")
                    .font(.headline)
                Text("Mom's Kitchen") // TODO
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                Text((item.price ?? 0).asDollarString)
                    .font(.subheadline)
                    .foregroundColor(.guelphRed)
            }.padding(.horizontal, 20)
                .padding([.top, .bottom], 10)
            
            Spacer()
            
            Button(action: deleteAction) {
                Image(systemName: "trash").foregroundColor(.guelphRed)
            }.padding()

        }.background(Color.white)
            .cornerRadius(5)
            .padding(.all, 10)
            .shadow(radius: 2)
            .onTapGesture {
                self.editAction()
        }
    }
    
    // MARK: Private
    
    private let item: GraphFoodItem
    private let editAction: () -> Void
    private let deleteAction: () -> Void

}

struct CartItemCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            CartItemCard(
                item: GraphFoodItem(id: "1", displayName: "Hamburger 1", price: 2),
                editAction: {},
                deleteAction: {})
            CartItemCard(
                item: GraphFoodItem(id: "1", displayName: "Hamburger 2", price: 2),
                editAction: {},
                deleteAction: {})
        }.background(Color.lightGray)
    }
}
