//
//  LoginView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - LoginView

struct LoginView: View {
    
    // MARK: Internal
    
    var body: some View {
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
                    .keyboardType(.emailAddress)
                
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
        }.errorAlert(error: self.$error.wrappedValue) {
            // If we do not "unset" the error, and assign an error that is the exact same type of the
            //old value, SwiftUI will not present the alert. Possible SwiftUI Bug?
            self.error = nil
        }.onAppear {
            if let user = self.viewModel.loggedInUser {
                self.presentPostLoginScreen(for: user)
            }
            
            self.email = ""
            self.password = ""
        }
    }
    
    // MARK: Private
    
    @State private var email = ""
    @State private var password = ""
    @State private var error: LoginViewModel.LoginError? = nil
    
    @EnvironmentObject private var state: LandingState
    @Environment(\.viewController) private var viewControllerHolder
    
    private let viewModel = LoginViewModel()
    
    private func attemptLogin() {
        switch viewModel.attemptLogin(username: email, password: password) {
        case .success(let user):
            self.presentPostLoginScreen(for: user)
        case .failure(let error):
            self.error = error
        }
    }
    
    private func presentPostLoginScreen(for user: User) {
        self.viewControllerHolder.value?.present(style: .fullScreen) {
            if user.userType == .restaurant {
                RestHomeView()
            } else {
                MainTabView()
            }
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
