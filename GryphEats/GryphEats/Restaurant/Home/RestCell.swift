//
//  RestCell.swift
//  GryphEats
//
//  Created by Owner on 11/10/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct RestCell<V: View>: View {
    var restaurant: Restaurant
    private var destinationView: () -> V
    @State var state: Bool = false
    @State var isSelected = false
    
    init(restaurant: Restaurant, destinationView: @escaping () -> V) {
        self.restaurant = restaurant
        self.destinationView = destinationView
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: destinationView()) {
                Image("hospitalityLogo").renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding([.horizontal, .top], 7)
            }
            Text(restaurant.name)
                .scaledToFit()
                .font(Font.custom("Roboto-Bold", size: restTitleSize))
                .lineLimit(1)
        }
        .clipped()
        .padding(.init(top: 20, leading: 0, bottom: 10, trailing: 0))
    }
    
    private var restTitleSize: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 26 : 40
    }
}
