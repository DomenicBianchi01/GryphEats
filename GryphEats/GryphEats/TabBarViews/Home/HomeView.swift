//
//  HomeView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - HomeView

struct HomeView: View {
    
    // MARK: Internal
    
    var body: some View {
        NavigationHeaderView(
            title: "GryphEats",
            navigationColor: .navigationGuelphYellow(for: colorScheme),
            contentBackgroundColor: .lightGray(for: colorScheme))
        {
            self.content
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().backgroundColor = .lightGray
            self.viewModel.fetchRestaurants()
        }
    }
    
    // MARK: Private
    
    @Environment(\.viewController) private var viewControllerHolder
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @ObservedObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var loggedInUser: User
    @EnvironmentObject private var state: LandingState
    
    @State private var pushItemActive = false
    
    // A terrible hack...
    static private var selectedItem: RestaurantFoodItem? = nil
    
    private func displayOrderReview() {
        viewControllerHolder.value?.present(style: .fullScreen) {
            OrderReviewView()
                .environmentObject(self.loggedInUser)
                .environmentObject(self.cart)
                .environmentObject(OrderReviewState())
        }
    }
    
    private var content: AnyView {
        switch viewModel.loadingState {
        case .loading:
            return AnyView(ActivityIndicatorView())
        case .loaded(let restaurants):
            return AnyView(VStack(alignment: .leading, spacing: 0) {
                SearchBar(placeholder: "Search for food") { searchText in
                    self.viewModel.filterRestaurants(by: searchText)
                }
                
                Divider()
                
                // Swift UI Bug: `listRowBackground` and `listRowInsets` do not work without nesting a `ForEach` within
                // `List`
                List {
                    ForEach(restaurants, id: \.id) { restaurant in
                        RestaurantItemsView(restaurant: restaurant) { item in
                            self.presentItemDetails(for: item)
                        }
                    }.listConfiguration(backgroundColor: .lightGray(for: colorScheme), removeInsets: true)
                }
            }.sheet(isPresented: $pushItemActive) {
                ItemOverview(item: HomeView.selectedItem!)
                    .environmentObject(self.cart)
            }.navigationBarItems(trailing: self.trailingNavigationBarItems)
                .dismissKeyboardOnTapGesture())
        case .error:
            return AnyView(ErrorView(infoText: "Whoops! We could not fetch the menus.", buttonText: "Try Again") {
                self.viewModel.fetchRestaurants()
            })
        }
    }
    
    private var trailingNavigationBarItems: some View {
        let action = {
            self.displayOrderReview()
        }
        
        return BadgeButton(badgeNumber: $cart.items.wrappedValue.count, action: action) {
            Image(systemName: "cart")
                .padding(.all, 10)
        }
    }
    
    private func presentItemDetails(for foodItem: RestaurantFoodItem) {
        HomeView.selectedItem = foodItem
        pushItemActive = true
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Cart())
    }
}
