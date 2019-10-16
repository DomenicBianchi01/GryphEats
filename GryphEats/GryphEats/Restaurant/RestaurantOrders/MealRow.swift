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
                        Text("1x").font(Font.custom("Roboto-Bold", size: 30)).padding(.leading)
                        Text("Hamburger").font(Font.custom("Roboto-Bold", size: 30))
                        Spacer()
                    }
                }
                HStack (alignment: .top, spacing: 6){
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("1x")
                            Text("Cheese")
                        }
                        HStack {
                            Text("2x")
                            Text("Onion")
                        }
                        HStack {
                            Text("1x")
                            Text("Pepper")
                        }
                    }.padding(.bottom).padding(.leading, 40)
                    Spacer()
                    VStack(alignment: .trailing, spacing: 6) {
                        Text("Additional Info")
                        Text("Nut Allergy")
                    }.padding(.bottom).padding(.trailing, 40)
                }.font(Font.custom("Roboto-Bold", size: 28))
                    .foregroundColor(.gray)
            }.padding(.top)            
        }
    }
}
