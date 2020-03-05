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
    
    init(restaurant: RestaurantDetails, onTap: @escaping (RestaurantFoodItem) -> Void) {
        self.restaurant = restaurant
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
//            HStack {
                Text(restaurant.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding([.top, .leading])
                
//                Spacer()
              
                //TODO: Do we even need the button that is commented out below?
                
//                ZStack(alignment: .leading) {
//                    Button(action: {}) {
//                        Text("View All")
//                    }.padding(.vertical, 10)
//                        .padding(.trailing, 30)
//
//                    Image(systemName: "chevron.right")
//                        .padding(.leading, 70)
//                }.foregroundColor(.gray)
//                    .padding(.top, 10)
//            }
            
            SliderView(type: .foodItems(foodItems)) { index in
                self.onTap(index)
            }
        }
    }
    
    // MARK: Private
    
    private let onTap: (RestaurantFoodItem) -> Void
    private let restaurant: RestaurantDetails
    
    private var foodItems: [RestaurantFoodItem] {
        guard let activeItems = restaurant.menu.first(where: { $0?.isActive == true }),
            let menuItems = activeItems?.menuItems.compactMap({ $0 }) else {
                return []
        }
        
        return menuItems.map {
            RestaurantFoodItem(
                foodItem: $0.item.fragments.foodItemDetails,
                imageURL: $0.item.imageUrl,
                restaurantId: restaurant.id,
                restaurantName: restaurant.name)
        }
    }
}

//struct RestaurantItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantItemsView(
//            restaurant: RestaurantDetails(
//                id: "1",
//                name: "100 Mile Grill",
//                isActive: true,
//                menu: [
//                    Menu(isActive: true, menuItems: [
//                        Menu.MenuItem(item:
//                            RestaurantMenusQuery.Data.Restaurant.Menu.MenuItem.Item(
//                                id: "1",
//                                name: "Hamburger 1",
//                                price: 2,
//                                inStock: true)),
//                        Menu.MenuItem(item:
//                            RestaurantMenusQuery.Data.Restaurant.Menu.MenuItem.Item(
//                                id: "2",
//                                name: "Hamburger 2",
//                                price: 2,
//                                inStock: true)),
//                        Menu.MenuItem(item:
//                            RestaurantMenusQuery.Data.Restaurant.Menu.MenuItem.Item(
//                                id: "3",
//                                name: "Hamburger 3",
//                                price: 2,
//                                inStock: true)),
//                        Menu.MenuItem(item:
//                            RestaurantMenusQuery.Data.Restaurant.Menu.MenuItem.Item(
//                                id: "4",
//                                name: "Hamburger 4",
//                                price: 2,
//                                inStock: true))
//                    ])
//                ]
//        )) { _ in }
//    }
//}
