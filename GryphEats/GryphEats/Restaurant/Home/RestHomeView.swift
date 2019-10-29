//
//  RestaurantHomeView.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/7/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import QGrid

//struct Restaurant2 : Codable, Identifiable {
//    var id: Int
//
//    let name: String
//    let imageName: String
//}
//
//let dummy = [Restaurant2(id: 1, name: "Mom's Kitchen", imageName: "Borger"), Restaurant2(id: 2, name: "100 Mile Grill", imageName: "Borger"), Restaurant2(id: 3, name: "Mongolian Grill", imageName: "Borger"), Restaurant2(id: 4, name: "Pizza", imageName: "Borger"), Restaurant2(id: 5, name: "Pasta", imageName: "Borger"), Restaurant2(id: 6, name: "Nacho", imageName: "Borger"), Restaurant2(id: 7, name: "Burrito", imageName: "Borger")]
//
//let ingredients1 = Ingredient(id: 0, name: "Cheese", imageName: "")
//let ingredients2 = Ingredient(id: 1, name: "Onion", imageName: "")
//let ingredients3 = Ingredient(id: 2, name: "Mushrooms", imageName: "")
//
//let foodItem1 = FoodItem(id: 0, name: "100 Mile Burger and Fries", imageName: "")
//let foodItem2 = FoodItem(id: 1, name: "100 Mile Burger and Fries", imageName: "", ingredients: [ingredients1])
//let foodItem3 = FoodItem(id: 2, name: "100 Mile Burger and Fries", imageName: "", ingredients: [ingredients2])
//let foodItem4 = FoodItem(id: 3, name: "100 Mile Burger and Fries", imageName: "", ingredients: [ingredients2, ingredients3])
//let foodItem5 = FoodItem(id: 4, name: "100 Mile Burger and Fries", imageName: "", ingredients: [ingredients1, ingredients2, ingredients3])
//
//let orders:[Order] = [
//    Order(id: 0, customer: Customer(name: "Domenic Bianchi", mealPlan: nil), status: .new, time: "11:29am", foodItems: [foodItem1]),
//    Order(id: 1, customer: Customer(name: "Matthew Bebis", mealPlan: nil), status: .new, time: "11:23am", foodItems: [foodItem2, foodItem3]),
//    Order(id: 2, customer: Customer(name: "Scott Riva", mealPlan: nil), status: .new, time: "11:20am", foodItems: [foodItem1, foodItem2, foodItem4]),
//    Order(id: 3, customer: Customer(name: "Shuaib Solker", mealPlan: nil), status: .new, time: "11:31am", foodItems: [foodItem1, foodItem2, foodItem3, foodItem4, foodItem5])]

struct RestHomeView: View {
    
    @Environment(\.viewController) private var viewControllerHolder

    var body: some View {
        NavigationHeaderView(title: "Stations", navigationColor: .guelphYellow, contentBackgroundColor: .white) {
            self.content.navigationBarItems(trailing: CircularButton(text: Text("Logout"), backgroundColor: .white, foregroundColor: .black) {
                self.viewControllerHolder.value?.dismiss(animated: true)
            }.padding(.top).layoutPriority(-1))
        }
        .onAppear {
            self.viewModel.fetchRestaurants()
        }
    }
    
    @ObservedObject private var viewModel = RestHomeViewModel()
    
    private var content: AnyView {
        switch viewModel.loadingState {
        case .loading:
            return AnyView(VStack {
                Spacer()
                ActivityIndicator(style: .large)
                Spacer()
            })
        case .loaded(let restaurants):
            if ( UIDevice.current.userInterfaceIdiom == .phone ) {
                return AnyView( QGrid(restaurants,
                                      columns: 2,
                                      columnsInLandscape: 2,
                                      vSpacing: 50,
                                      hSpacing: 5,
                                      vPadding: 1,
                                      hPadding: 20) {
                                        restaurant in GridCell(restaurant: restaurant)
                })
            } else {
                return AnyView(QGrid(restaurants,
                                      columns: 3,
                                      columnsInLandscape: 3,
                                      vSpacing: 50,
                                      hSpacing: 5,
                                      vPadding: 1,
                                      hPadding: 20) {
                                        restaurant in GridCell(restaurant: restaurant)
                })
            }
        case .error:
            return AnyView(ErrorView(infoText: "Whoops! We could not fetch the stations.", buttonText: "Try Again") {
                self.viewModel.fetchRestaurants()
            })
        }
    }
}
struct GridCell: View {
    var restaurant: Restaurant
    @State var state: Bool = false
    @State var isSelected = false

    var body: some View {
        VStack {
            NavigationLink(destination: RestOrdersView(restID: restaurant.id).navigationBarTitle("Orders")) {
                Image("Borger").renderingMode(.original)
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

struct RestHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RestHomeView()
    }
}

