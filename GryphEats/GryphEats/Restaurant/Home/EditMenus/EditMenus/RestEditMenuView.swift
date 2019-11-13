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
    
    let rest = [
        Restaurant(
            id: "1",
            name: "Burger",
            isOpen: true,
            foodItems: []),
        Restaurant(
            id: "2",
            name: "Chicken",
            isOpen: true,
            foodItems: []),
        Restaurant(
            id: "3",
            name: "Pasta",
            isOpen: true,
            foodItems: [])
    ]
    
    @Environment(\.viewController) private var viewControllerHolder
    var restID: String
    
    init(restID: String) {
        self.restID = restID
        viewModel = RestEditMenuViewModel(restID: restID)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 42)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 30)!]
    }
    
    var body: some View {
        self.content.navigationBarTitle("Edit Menus")
            .onAppear {
                self.viewModel.fetchMenus()
        }
    }
    
    @ObservedObject private var viewModel: RestEditMenuViewModel
    
    private var content: AnyView {
        switch viewModel.loadingState {
        case .loading:
            return AnyView(ActivityIndicatorView())
        case .loaded(let restaurantMenu):
            return AnyView(
                VStack(alignment: .leading) {
                    
                    ToggleButton(selectedState: restaurantMenu.isOpen ? .left : .right, text1: "Open", text2: "Closed", onTap: {}).padding(.all, 30)

                    QGrid(restaurantMenu.foodItems,
                          columns: 3,
                          columnsInLandscape: 3,
                          vSpacing: 0,
                          hSpacing: 0,
                          vPadding: 5,
                          hPadding: 20) { item in
                            FoodCard(foodItem: item, onTap: {})
                    }
                    ActionButton(text: "Save Menu") {
                        //todo
                    }.padding(.vertical, 30)
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
            CheckBoxRow(itemName: itemName, onTap: {})
        }
    }
}
