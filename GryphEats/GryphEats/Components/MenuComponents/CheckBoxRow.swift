//
//  CheckBoxCard.swift
//  GryphEats
//
//  Created by Matthew Bebis on 11/2/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CheckBoxRow

struct CheckBoxRow: View {
    
    // MARK: Lifecycle
    
    init(itemName: String, onTap: @escaping () -> Void) {
        self.itemName = itemName
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        Button (action: {
            self.onTap()
            self.isSelected.toggle()
        }) {
            HStack(alignment: .top) {
                Rectangle()
                    .fill(isSelected ? Color.guelphRed : Color.lightGray)
                    .frame(width: 22, height: 22, alignment: .center)
                    .cornerRadius(5)
                    .shadow(radius: 2)
                    .padding([.vertical, .leading])
                Text(itemName)
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
                    .padding([.vertical, .leading])
                Spacer()
            }
        }.contentShape(Rectangle())
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 2)
            .opacity(isSelected ? 1.0 : 0.6)
    }
    
    // MARK: Private
    
    @State var isSelected: Bool = false
    
    private let onTap: () -> Void
    private let itemName: String
    private let frameSize = CGSize(width: 150, height: 200)
    
}

struct CheckBoxCard_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxRow(itemName: "Ketchup", onTap: { print("Tapped") })
    }
}
