//
//  RestaurantItemsView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - RestaurantItemsView

struct RestaurantItemsView: View {
    
    // MARK: Lifecycle
    
    init(restaurant: GraphRestaurant, onTap: @escaping (Int) -> Void) {
        self.restaurant = restaurant
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(restaurant.name)
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
            
            SliderView(type: .foodItems(foodItems)) { index in
                self.onTap(index)
            }
        }
    }
    
    // MARK: Private
    
    private let onTap: (Int) -> Void
    private let restaurant: GraphRestaurant
    
    private var foodItems: [RestaurantFoodItem] {
        guard let activeItems = restaurant.menu?.first(where: { $0?.isActive == true }),
            let menuItems = activeItems?.menuItems?.compactMap({ $0 }) else {
                return []
        }
        
        return menuItems.compactMap {
            $0.item.flatMap {
                RestaurantFoodItem(foodItem: $0, restaurantId: restaurant.id, restaurantName: restaurant.name)
            }
        }
    }
}

struct RestaurantItemsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantItemsView(
            restaurant: GraphRestaurant(
                id: "1",
                name: "100 Mile Grill",
                menu: [
                    Menu(menuItems: [
                        Menu.MenuItem(item:
                            GraphFoodItem(id: "1", displayName: "Hamburger 1", price: 2)),
                        Menu.MenuItem(item:
                            GraphFoodItem(id: "2", displayName: "Hamburger 2", price: 2)),
                        Menu.MenuItem(item:
                            GraphFoodItem(id: "3", displayName: "Hamburger 3", price: 2)),
                        Menu.MenuItem(item:
                            GraphFoodItem(id: "4", displayName: "Hamburger 4", price: 2))
                    ])
            ])) { _ in }
        
        
        //        Restaurant(
        //                       id: "0",
        //                       name: "100 Mile Grill",
        //                       foodItems: [
        //                           FoodItem(id: 0, name: "Hamburger 1", imageName: "hamburger"),
        //                           FoodItem(id: 1, name: "Hamburger 2", imageName: "hamburger"),
        //                           FoodItem(id: 2, name: "Hamburger 3", imageName: "hamburger"),
        //                           FoodItem(id: 3, name: "Hamburger 4", imageName: "hamburger"),
        //                           FoodItem(id: 4, name: "Hamburger 5", imageName: "hamburger")
        //                   ])) { _ in }
    }
}
