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
                        if let error = self.state.validatePasswordInput() {
                            self.error = error
                        } else {
                            withAnimation {
                                self.state.reset()
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

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView().environmentObject(LandingState())
    }
}
