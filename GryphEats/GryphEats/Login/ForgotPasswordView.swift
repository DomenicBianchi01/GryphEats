//
//  ForgotPasswordView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - ForgotPasswordView

struct ForgotPasswordView: View {
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
            BackButton {
                withAnimation {
                    self.state.reset()
                }
            }
            
            HeaderView(title: "Forgot Password", subtitle: "")
                .foregroundColor(.white)
            
            CustomTextField(
                header: "Email".uppercased(),
                placeholder: "Please enter your email",
                text: self.$state.email)
                .keyboardType(.emailAddress)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
            
            Spacer()
            
            HStack {
                Spacer()
                CircularButton(
                    text: Text("Continue"),
                    backgroundColor: .white,
                    foregroundColor: .black) {
                        if let error = self.state.validateForgotPasswordInput() {
                            self.error = error
                        } else {
                            withAnimation {
                                self.state.state = .answerQuestion
                            }
                        }
                }.shadow(radius: 5).padding()
                Spacer()
            }
        }.errorAlert(error: self.$error.wrappedValue) {
            // If we do not "unset" the error, and assign an error that is the exact same type of the
            //old value, SwiftUI will not present the alert. Possible SwiftUI Bug?
            self.error = nil
        }
    }
    
    // MARK: Private
    
    @State private var error: LandingState.LandingError? = nil
    
    @EnvironmentObject private var state: LandingState
    
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(LandingState())
            .background(Color.gray)
    }
}
