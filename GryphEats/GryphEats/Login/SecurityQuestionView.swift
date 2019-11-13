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
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: UIDevice.current.isPad ? .center : .leading) {
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
                    header: "Question".uppercased(),
                    placeholder: "Please enter a question",
                    text: self.$state.question)
                    .padding(.bottom, 20)
                
                CustomTextField(
                    header: "Answer".uppercased(),
                    placeholder: "Please enter the answer to the question",
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
                        if self.state.validateSecurityQuestion() != nil {
                            self.error = .accountCreationError
                        } else {
                            //TODO: Update registration to include two input fields rather than one for name input.
                            let firstName = String(self.state.name.split(separator: " ").first ?? "")
                            let lastName = String(self.state.name.split(separator: " ").last ?? "")
                            
                            self.viewModel.createAccount(
                                firstName: firstName,
                                lastName: lastName,
                                email: self.state.email,
                                password: self.state.password,
                                question: self.state.question,
                                answer: self.state.password)
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
                title: Text("Welcome to GryphEats!"),
                message: Text("You can now login to your account!"),
                dismissButton: .default(Text("OK")) {
                    withAnimation {
                        self.state.reset()
                    }
                })
        }
    }
    
    // MARK: Private
    
    @State private var showConfirmationAlert = false
    @State private var error: CreateAccountViewModel.CreateAccountError? = nil
    @EnvironmentObject private var state: LandingState
    
    private let viewModel = CreateAccountViewModel()
    
}

struct SecurityQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityQuestionView()
            .environmentObject(LandingState())
            .background(Color.gray)
    }
}
