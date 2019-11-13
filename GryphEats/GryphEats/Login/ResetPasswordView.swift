//
//  ResetPasswordView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-06.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - ResetPasswordView

struct ResetPasswordView: View {
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: UIDevice.current.isPad ? .center : .leading) {
            BackButton {
                withAnimation {
                    self.state.reset()
                }
            }
            
            Group {
                HeaderView(title: "Reset Password", subtitle: "")
                
                Group {
                    CustomTextField(
                        header: "Password".uppercased(),
                        placeholder: "Please enter a new password",
                        text: self.$state.password,
                        isSecure: true)
                    
                    Text("Password must contain at least 6 characters")
                        .font(.caption)
                }.padding(.horizontal, 40)
            }.foregroundColor(.white)
            
            Spacer()
            
            HStack {
                Spacer()
                CircularButton(
                    text: Text("Continue"),
                    backgroundColor: .white,
                    foregroundColor: .black) {
                        if self.state.validatePasswordInput() != nil {
                            self.error = .invalidPassword
                        } else {
                            self.viewModel.updatePassword(
                                email: self.state.email,
                                newPassword: self.state.password)
                            { result in
                                switch result {
                                case .success:
                                    self.showConfirmationAlert = true
                                case .failure(let error):
                                    self.error = error
                                }
                            }
                        }
                }.shadow(radius: 5).padding()
                Spacer()
            }
        }.errorAlert(error: self.$error.wrappedValue) {
            // If we do not "unset" the error, and assign an error that is the exact same type of the
            //old value, SwiftUI will not present the alert. Possible SwiftUI Bug?
            self.error = nil
        }.alert(isPresented: $showConfirmationAlert) {
            Alert(
                title: Text("Password Reset"),
                message: Text("You can now login using your new password."),
                dismissButton: .default(Text("OK")) {
                    withAnimation {
                        self.state.reset()
                    }
                })
        }
    }
    
    // MARK: Private
    
    @State private var showConfirmationAlert = false
    @State private var error: ResetPasswordViewModel.ResetPasswordError? = nil
    @EnvironmentObject private var state: LandingState
    
    private let viewModel = ResetPasswordViewModel()
    
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView().environmentObject(LandingState())
    }
}
