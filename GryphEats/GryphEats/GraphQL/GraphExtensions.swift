//
//  GraphEquatableExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-28.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// The typealias' below exist just for convenience

typealias GraphRestaurant = RestaurantMenusQuery.Data.Restaurant
typealias Menu = GraphRestaurant.Menu
typealias GraphFoodItem = Menu.MenuItem.Item

// GraphQL structs do not conform to `Equatable` by default.

extension GraphFoodItem: Equatable {
    public static func == (
        lhs: RestaurantMenusQuery.Data.Restaurant.Menu.MenuItem.Item,
        rhs: RestaurantMenusQuery.Data.Restaurant.Menu.MenuItem.Item) -> Bool
    {
        return lhs.id == rhs.id &&
            lhs.displayName == rhs.displayName &&
            lhs.price == rhs.price
    }
}
