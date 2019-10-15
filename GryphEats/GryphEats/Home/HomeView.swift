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
            self.content
        }.onAppear {
            self.viewModel.fetchRestaurants()
        }
    }
    
    // MARK: Private
    
    @State private var pushItemActive = false
    @State private var showOrderReview: Bool = false
    
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var activeItem: ActiveFoodItem
    
    @ObservedObject private var viewModel = HomeViewModel()
    
    private var content: AnyView {
        switch viewModel.loadingState {
        case .loading:
            return AnyView(VStack {
                Spacer()
                ActivityIndicator(style: .large)
                Spacer()
            })
        case .loaded(let restaurants):
            return AnyView(VStack(alignment: .leading, spacing: 0) {
                SliderView(type: .categories(self.viewModel.categories)) { index in
                    print("Tapped category card \(index)")
                }.background(Color.white)
                
                Divider()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(restaurants) { restaurant in
                            RestaurantItemsView(restaurant: restaurant) { index in
                                self.presentItemDetails(for: restaurant.foodItems[index])
                            }
                        }
                    }
                }.background(Color.lightGray)
                
                NavigationLink(destination: ItemOverview(), isActive: self.$pushItemActive) {
                    Text("")
                }.hidden()
                
            }.edgesIgnoringSafeArea(.bottom)
                .navigationBarItems(trailing: self.trailingNavigationBarItems))
        case .error:
            return AnyView(ErrorView(infoText: "Whoops! We could not fetch the menus.", buttonText: "Try Again") {
                self.viewModel.fetchRestaurants()
            })
        }
    }
    
    private var trailingNavigationBarItems: some View {
        let action = {
            self.showOrderReview = true
        }
        
        return BadgeButton(badgeNumber: $cart.items.wrappedValue.count, action: action) {
            Image(systemName: "cart")
                .padding(.all, 10)
                .foregroundColor(.black)
        }.sheet(isPresented: $showOrderReview) {
            OrderReviewView()
                .environmentObject(self.cart)
                .environmentObject(OrderReviewState())
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
