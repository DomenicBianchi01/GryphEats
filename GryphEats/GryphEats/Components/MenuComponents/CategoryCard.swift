//
//  CategoryCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CategoryCard

struct CategoryCard: View {
    
    // MARK: Lifecycle
    
    init(name: String, onTap: @escaping () -> Void) {
        self.name = name
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        Group {
            Button(action: onTap) {
                Text(name)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
            }
        }.background(Color.yellow)
            .cornerRadius(5)
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
    }
    
    // MARK: Private
    
    private let onTap: () -> Void
    private let name: String
    
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(name: "Test") {
            print("Card tapped")
        }
    }
}
