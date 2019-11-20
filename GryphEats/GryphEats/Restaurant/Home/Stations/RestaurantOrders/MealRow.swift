//
//  OrderDetailRow.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/13/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import QGrid

struct MealRow: View {
    var body: some View {
        HStack(alignment: .top)  {
            VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color.guelphYellow)
                    HStack(alignment: .top) {
                        Text("1x").font(.system(size: 28, weight: .bold)).padding(.leading)
                        Text(foodItem.name).font(.system(size: 28, weight: .bold))
                        Spacer()
                    }.scaledToFill()
                }
                HStack (alignment: .top, spacing: 6){
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(foodItem.ingredients ?? []) { ingredient in
                            HStack {
                                Text("1x")
                                Text(ingredient.name)
                            }
                        }
                    }.padding(.bottom).padding(.leading, 40)
                    .font(Font.custom("Roboto-Bold",size: 28))
                    .foregroundColor(.gray)
                    Spacer()
                }
            }
        }.padding(.all)
        .contentShape(Rectangle())
        .background(Color(red: 245/255, green: 245/255, blue: 245/255))
        .cornerRadius(14)
//        .shadow(radius: 2)
    }
    
    var foodItem: GraphFoodItem
    
}
