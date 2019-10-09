//
//  Resturant.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: Resturant

struct Resturant: Identifiable {
    
    // MARK: Internal
    
    let id: Int
    let name: String
    let foodItems: [FoodItem]

}
