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
        VStack(alignment: .leading) {
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
                        header: Text("Full Name".uppercased()),
                        placeholder: Text("Please enter your first and last name"),
                        text: self.$state.name)
                    
                    CustomTextField(
                        header: Text("Email".uppercased()),
                        placeholder: Text("Please enter your email"),
                        text: self.$state.email)
                }.keyboardType(.emailAddress)
                    .padding(.bottom, 20)
                
                CustomTextField(
                    header: Text("Password".uppercased()),
                    placeholder: Text("Please enter a password"),
                    text: self.$state.password,
                    isSecure: true)
                
                Text("Password must contain at least 6 characters").font(.caption)
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
    
    @State private var error: RegistrationState.RegistrationError? = nil
    
    @EnvironmentObject private var state: RegistrationState

}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(RegistrationState())
            .background(Color.gray)
    }
}
