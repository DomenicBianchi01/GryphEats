//
//  OrderRow.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/12/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct OrderRow: View {
    var body: some View {
        ZStack() {
            Rectangle()
                .background(Color.red)
                .foregroundColor(.clear)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .opacity(0.4)
            
            VStack(alignment: .leading) {
                //            HStack(){
                //                Spacer()
                //            }.padding(.leading)
                Text("Domenic Bianchi")
                    .font(Font.custom("Roboto-Regular", size: 20))
                    .lineLimit(1)
                    .padding(.leading)
                    .padding(.top)
                Text("11:28am")
                    .font(Font.custom("Roboto-Regular", size: 16))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .padding(.leading)
                    .opacity(0.9)
                Divider().padding(.leading).padding(.trailing)
                Text("2 Items")
                    .font(Font.custom("Roboto-Bold", size: 18))
                    .lineLimit(1)
                    .padding(.leading)
                    .padding(.bottom)
            }
        }
    }
}
