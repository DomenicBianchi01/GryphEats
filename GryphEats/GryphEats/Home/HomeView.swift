//
//  HomeView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - HomeView

struct HomeView: View {
    
    // MARK: Internal
    
    var body: some View {
        NavigationHeaderView(
            title: "GryphEats",
            navigationColor: .guelphYellow,
            contentBackgroundColor: .lightGray)
        {
            VStack(alignment: .leading, spacing: 0) {
                SliderView(type: .categories(self.viewModel.categories)) { index in
                    print("Tapped category card \(index)")
                }.background(Color.white)
                
                Divider()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(self.viewModel.resturants) { resturant in
                            ResturantItemsView(resturant: resturant) { index in
                                self.presentItemDetails(for: resturant.foodItems[index])
                            }
                        }
                    }
                }.background(Color.lightGray)
                
                NavigationLink(destination: ItemOverview(), isActive: self.$pushItemActive) {
                  Text("")
                }.hidden()
    
            }.edgesIgnoringSafeArea(.bottom)
                .navigationBarItems(trailing: self.trailingNavigationBarItems)
        }
    }
    
    // MARK: Private
    
    @State private var pushItemActive = false
    @State private var showOrderReview: Bool = false
    
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var activeItem: ActiveFoodItem
    
    private let viewModel = HomeViewModel()
    
    private var trailingNavigationBarItems: some View {
        return Button(action: { self.showOrderReview = true }) {
            Image(systemName: "cart").padding(.all, 10)
        }.foregroundColor(.black)
            .sheet(isPresented: $showOrderReview) {
                OrderReviewView()
        }
    }
    
    private func presentItemDetails(for foodItem: FoodItem) {
        activeItem.item = foodItem
        pushItemActive = true
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
