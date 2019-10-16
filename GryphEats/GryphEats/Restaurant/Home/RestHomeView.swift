//
//  RestaurantHomeView.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/7/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import QGrid

struct Restaurant2 : Codable, Identifiable {
    var id: Int
    
    let name: String
    let imageName: String
}

let dummy = [Restaurant2(id: 1, name: "Mom's Kitchen", imageName: "Borger"), Restaurant2(id: 2, name: "100 Mile Grill", imageName: "Borger"), Restaurant2(id: 3, name: "Mongolian Grill", imageName: "Borger"), Restaurant2(id: 4, name: "Pizza", imageName: "Borger"), Restaurant2(id: 5, name: "Pasta", imageName: "Borger"), Restaurant2(id: 6, name: "Nacho", imageName: "Borger"), Restaurant2(id: 7, name: "Burrito", imageName: "Borger")]

struct RestHomeView: View {
    var body: some View {
        NavigationHeaderView(title: "Stations", navigationColor: .guelphYellow, contentBackgroundColor: .white) {
            QGrid(dummy,
                  columns: 3,
                  columnsInLandscape: 3,
                  vSpacing: 50,
                  hSpacing: 5,
                  vPadding: 1,
                  hPadding: 20) {
                    restaurant in GridCell(restaurant: restaurant)
            }
        }
    }
}

struct GridCell: View {
    var restaurant: Restaurant2
    
    var body: some View {
        VStack {
            Image(restaurant.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .padding([.horizontal, .top], 7)
            Text(restaurant.name)
                .font(Font.custom("Roboto-Bold", size: 40))
                .lineLimit(1)
        }
        .clipped()
        .padding(.init(top: 20, leading: 0, bottom: 10, trailing: 0))
    }
}

struct RestHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RestHomeView()
    }
}

