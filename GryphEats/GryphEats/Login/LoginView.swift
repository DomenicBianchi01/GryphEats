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
        
        switch viewModel.attemptLogin() {
        case .success:
            self.viewController?.present(style: .fullScreen) {
                if (restaurantUser.type == 1 && restaurantUser.username == email && restaurantUser.password == password) {
                    RestHomeView()
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
