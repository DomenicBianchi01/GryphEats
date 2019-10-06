//
//  SecurityQuestionView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - SecurityQuestionView

struct SecurityQuestionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            BackButton {
                withAnimation {
                    self.state.state = .info
                }
            }
            
            HeaderView(
                title: "Security Question",
                subtitle: "Create a question that must be answered if you ever need to reset your password!")
                .foregroundColor(.white)
            
            Group {
                CustomTextField(
                    header: Text("Question".uppercased()),
                    placeholder: Text("Please enter a question"),
                    text: self.$state.question)
                    .padding(.bottom, 20)
                
                CustomTextField(
                    header: Text("Answer".uppercased()),
                    placeholder: Text("Please enter the answer to the question"),
                    text: self.$state.answer)
            }.foregroundColor(.white)
                .padding(.horizontal, 40)
            
            Spacer()
            
            HStack {
                Spacer()
                CircularButton(
                    text: Text("Register"),
                    backgroundColor: .white,
                    foregroundColor: .black) {
                        if let error = self.state.validateSecurityQuestion() {
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
    
    @State private var error: RegistrationState.RegistrationError? = nil
    
    @EnvironmentObject private var state: RegistrationState

}

struct SecurityQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityQuestionView().environmentObject(RegistrationState())
    }
}
