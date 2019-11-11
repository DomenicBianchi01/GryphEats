//
//  OrderDetailRow.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/13/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct MealRow: View {
    var body: some View {
        HStack(alignment: .top)  {
            VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color.guelphYellow)
                    HStack(alignment: .top, spacing: 8) {
                        Text("1x").font(Font.custom("Roboto-Bold", size: 28)).padding(.leading)
                        Text(foodItem.name).font(Font.custom("Roboto-Bold", size: 28))
                        Spacer()
                    }.scaledToFill()
                }
                HStack (alignment: .top, spacing: 6){
                    VStack(alignment: .leading, spacing: 6) {
                        //below needed to write ingridients
                        Text("")
                        //                            ForEach(foodItem.ingredients) { ingredient in
                        //                                HStack {
                        //                                    Text("1x")
                        //                                    Text(ingredient.name)
                        //                                }
                        //                            }
                    }.padding(.bottom).padding(.leading, 40)
                    Spacer()
                }.font(Font.custom("Roboto-Bold", size: 28))
                    .foregroundColor(.gray)
            }.padding(.top)
        }
    }
    
    var foodItem: GraphFoodItem
    
}
