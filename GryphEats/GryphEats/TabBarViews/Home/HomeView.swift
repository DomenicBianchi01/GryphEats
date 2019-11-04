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
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().backgroundColor = .lightGray
            self.viewModel.fetchRestaurants()
        }
    }
    
    // MARK: Private
    
    @State private var showOrderReview: Bool = false
    @ObservedObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var cart: Cart
    
    private var content: AnyView {
        switch viewModel.loadingState {
        case .loading:
            return AnyView(ActivityIndicatorView())
        case .loaded(let restaurants):
            return AnyView(VStack(alignment: .leading, spacing: 0) {
                SliderView(type: .categories(self.viewModel.categories)) { index in
                    print("Tapped category card \(index)")
                }.background(Color.white)
                
                Divider()
                
                // Swift UI Bug: `listRowBackground` and `listRowInsets` do not work without nesting a `ForEach` within
                // `List`
                List {
                    ForEach(restaurants, id: \.id) { restaurant in
                        RestaurantItemsView(restaurant: restaurant) { _ in }
                    }.listConfiguration(backgroundColor: Color.lightGray)
                }
            }.navigationBarItems(trailing: self.trailingNavigationBarItems))
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Cart())
    }
}
