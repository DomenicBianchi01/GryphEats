//
//  LoginView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var restaurantUser = User(type: 1, username: "Test", password: "password")
    
    var body: some View {
        HStack {
            VStack {
                Image("AppLogo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(20)
                    .padding(.bottom, 20)
                
                Group {
                    CustomTextField(
                        header: "Email".uppercased(),
                        placeholder: "Please enter your email",
                        text: self.$email)
                        .padding(.bottom, 20)
                    
                    CustomTextField(
                        header: "Password".uppercased(),
                        placeholder: "Please enter your password",
                        text: self.$password,
                        isSecure: true)
                        .padding(.bottom, 40)
                }.foregroundColor(.white)
                    .padding(.horizontal, 40)
                
                HStack {
                    Spacer()
                    CircularButton(
                        text: Text("Sign In"),
                        backgroundColor: .white,
                        foregroundColor: .black) {
                            self.attemptLogin()
                    }.padding(.trailing, 25)
                    
                    CircularButton(
                        text: Text("Register"),
                        backgroundColor: .clear,
                        foregroundColor: .white,
                        borderColor: .white) {
                            withAnimation {
                                self.state.state = .info
                            }
                    }
                    Spacer()
                }
                Spacer()
                Button(action: {
                    withAnimation {
                        self.state.state = .forgotPassword
                    }
                }) {
                    Text("Forgot Password")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .padding()
                }
            }
        }.errorAlert(error: self.$error.wrappedValue) {
            // If we do not "unset" the error, and assign an error that is the exact same type of the
            //old value, SwiftUI will not present the alert. Possible SwiftUI Bug?
            self.error = nil
        }
    }
    
    // MARK: Private
    
    @State private var email = ""
    @State private var password = ""
    @State private var error: LoginViewModel.LoginError? = nil
    
    @EnvironmentObject private var state: LandingState
    @Environment(\.viewController) private var viewControllerHolder
    
    private let viewModel = LoginViewModel()
    
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    private func attemptLogin() {
        
        let ingredients1 = Ingredient(id: 0, name: "Cheese", imageName: "")
        let ingredients2 = Ingredient(id: 1, name: "Onion", imageName: "")
        let ingredients3 = Ingredient(id: 2, name: "Mushrooms", imageName: "")

        let foodItem1 = FoodItem(id: 0, name: "100 Mile Burger and Fries", imageName: "")
        let foodItem2 = FoodItem(id: 1, name: "100 Mile Burger and Fries", imageName: "", ingredients: [ingredients1])
        let foodItem3 = FoodItem(id: 2, name: "100 Mile Burger and Fries", imageName: "", ingredients: [ingredients2])
        let foodItem4 = FoodItem(id: 3, name: "100 Mile Burger and Fries", imageName: "", ingredients: [ingredients2, ingredients3])
        let foodItem5 = FoodItem(id: 4, name: "100 Mile Burger and Fries", imageName: "", ingredients: [ingredients1, ingredients2, ingredients3])
        
        let orders:[Order] = [
            Order(id: 0, customer: Customer(name: "Domenic Bianchi", mealPlan: nil), status: .new, time: "11:29am", foodItems: [foodItem1]),
        Order(id: 1, customer: Customer(name: "Matthew Bebis", mealPlan: nil), status: .new, time: "11:23am", foodItems: [foodItem2, foodItem3]),
        Order(id: 2, customer: Customer(name: "Scott Riva", mealPlan: nil), status: .new, time: "11:20am", foodItems: [foodItem1, foodItem2, foodItem4]),
        Order(id: 3, customer: Customer(name: "Shuaib Solker", mealPlan: nil), status: .new, time: "11:31am", foodItems: [foodItem1, foodItem2, foodItem3, foodItem4, foodItem5])]
        
        switch viewModel.attemptLogin() {
        case .success:
            self.viewController?.present(style: .fullScreen) {
                if (restaurantUser.type == 1 && restaurantUser.username == email && restaurantUser.password == password) {
                    RestOrdersView(orders: orders)
                }
                else {
                    MainTabView()
                }
            }
        case .failure(let error):
            self.error = error
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LandingState())
            .background(Color.gray)
    }
}
