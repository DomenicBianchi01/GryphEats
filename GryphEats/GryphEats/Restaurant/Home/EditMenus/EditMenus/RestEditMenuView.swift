//
//  RestEditMenuView.swift
//  GryphEats
//
//  Created by Owner on 11/9/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import QGrid

struct RestEditMenuView: View {
    
    @Environment(\.viewController) private var viewControllerHolder
    var restID: String
    var restName: String
    
    init(restID: String, restName: String) {
        self.restID = restID
        self.restName = restName
        viewModel = RestEditMenuViewModel(restID: restID)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 42)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 30)!]
    }
    
    var body: some View {
        self.content.navigationBarTitle("Edit "+restName+" Menu")
            .onAppear {
                self.viewModel.fetchMenus()
        }.errorAlert(error: self.$error.wrappedValue) {
            // If we do not "unset" the error, and assign an error that is the exact same type of the
            //old value, SwiftUI will not present the alert. Possible SwiftUI Bug?
            self.error = nil
        }
    }
    
    @State private var error: RestEditMenuViewModel.UpdateFoodError? = nil

    @ObservedObject private var viewModel: RestEditMenuViewModel
    
    private var content: AnyView {
        switch viewModel.loadingState {
        case .loading:
            return AnyView(ActivityIndicatorView())
        case .loaded(let restaurant):
            return AnyView(
                VStack(alignment: .leading) {
                    
                    ToggleButton(selectedState: restaurant.isOpen ? .left : .right, text1: "Open", text2: "Closed", onTap: { isSelected in
                        self.viewModel.mutateRestaurantActive(restID: restaurant.id, isActive: isSelected == .left ? true : false)
                    }).padding(.all, 30)

                    QGrid(restaurant.foodItems,
                          columns: 3,
                          columnsInLandscape: 3,
                          vSpacing: 0,
                          hSpacing: 0,
                          vPadding: 5,
                          hPadding: 20) { item in
                            FoodCard(foodItem: item, onTap: {
                                self.viewModel.mutateFoodAvailability(foodID: item.id, isAvailable: item.isavailable ? "0" : "1")
                                self.viewModel.ninjaFetchMenus()
                            }, onCommit: { price in
                                self.viewModel.mutateFoodPrice(foodID: item.id, price: price)
                            })
                    }
                }
            )
        case .error:
            return AnyView(ErrorView(infoText: "Whoops! We could not fetch the menu you requested.", buttonText: "Try Again") {
                self.viewModel.fetchMenus()
            })
        }
    }
    
}

struct RestMenuItemCell: View {
    var itemName: String
    
    var body: some View {
        VStack{
            Image("Borger")
            CheckBoxRow(itemName: itemName, isSelected: false, onTap: {})
        }
    }
}
