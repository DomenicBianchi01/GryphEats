//
//  ResturantItemsView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - ResturantItemsView

struct ResturantItemsView: View {
    
    // MARK: Lifecycle
    
    init(resturant: Resturant, onTap: @escaping (Int) -> Void) {
        self.resturant = resturant
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(resturant.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                
                Spacer()
                
                ZStack(alignment: .leading) {
                    Button(action: {}) {
                        Text("View All")
                    }.padding(.vertical, 10)
                        .padding(.trailing, 30)
                    
                    Image(systemName: "chevron.right")
                        .padding(.leading, 70)
                }.foregroundColor(.gray)
                    .padding(.top, 10)
            }
            
            SliderView(type: .foodItems(resturant.foodItems)) { index in
                self.onTap(index)
            }
        }
    }
    
    // MARK: Private
    
    private let onTap: (Int) -> Void
    private let resturant: Resturant
    
}

struct ResturantItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ResturantItemsView(
            resturant: Resturant(
                id: 0,
                name: "100 Mile Grill",
                foodItems: [
                    FoodItem(id: 0, name: "Hamburger 1", imageName: "hamburger"),
                    FoodItem(id: 1, name: "Hamburger 2", imageName: "hamburger"),
                    FoodItem(id: 2, name: "Hamburger 3", imageName: "hamburger"),
                    FoodItem(id: 3, name: "Hamburger 4", imageName: "hamburger"),
                    FoodItem(id: 4, name: "Hamburger 5", imageName: "hamburger")
            ])) { _ in }
    }
}
