//
//  RegisterView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - RegisterView

struct RegisterView: View {
    
    // MARK: Internal

    var body: some View {
        VStack(alignment: UIDevice.current.isPad ? .center : .leading) {
            BackButton {
                withAnimation {
                    self.state.reset()
                }
            }
            
            HeaderView(title: "Basic Information", subtitle: "Please fill out all the fields below!")
                .foregroundColor(.white)
            
            Group {
                Group {
                    CustomTextField(
                        header: "Full Name",
                        placeholder: "Please enter your first and last name",
                        text: self.$state.name)
                    
                    CustomTextField(
                        header: "Email",
                        placeholder: "Please enter your email",
                        text: self.$state.email)
                        .keyboardType(.emailAddress)
                }.padding(.bottom, 20)
                
                CustomTextField(
                    header: "Password".uppercased(),
                    subtitle: "Password must contain at least 6 characters",
                    placeholder: "Please enter a password",
                    text: self.$state.password,
                    isSecure: true)
            }.foregroundColor(.white)
                .padding(.horizontal, 40)
            
            Spacer()
            
            HStack {
                Spacer()
                CircularButton(
                    text: Text("Continue"),
                    backgroundColor: .white,
                    foregroundColor: .black) {
                        if let error = self.state.validateBasicInfoInput() {
                            self.error = error
                        } else {
                            withAnimation {
                                self.state.state = .security
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(LandingState())
            .background(Color.gray)
    }
}
