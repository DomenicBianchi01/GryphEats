//
//  AnswerQuestionView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - AnswerQuestionView

struct AnswerQuestionView: View {
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: UIDevice.current.isPad ? .center : .leading) {
            BackButton {
                withAnimation {
                    self.state.reset()
                }
            }
            
            HeaderView(
                title: "Security Question",
                subtitle: "You must answer the question below correctly in order to reset your password.")
                .foregroundColor(.white)
                .padding(.bottom, 10)
            
            Text(state.question)
                .underline()
                .bold()
                .foregroundColor(.white)
                .padding([.horizontal, .bottom], 40)
            
            CustomTextField(
                header: "Answer".uppercased(),
                placeholder: "Please enter the answer to the question",
                text: self.$state.answer)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
            
            Spacer()
            
            HStack {
                Spacer()
                CircularButton(
                    text: Text("Continue"),
                    backgroundColor: .white,
                    foregroundColor: .black) {
                        if self.state.validateForgotPasswordInput() != nil {
                            self.error = .emptyAnswer
                        } else {
                            self.viewModel.validateSecurityAnswer(
                                email: self.state.email,
                                answer: self.state.answer)
                            { result in
                                switch result {
                                case .success(let isCorrect):
                                    if isCorrect {
                                        withAnimation {
                                            self.state.state = .resetPassword
                                        }
                                    } else {
                                        self.error = .invalidAnswer
                                    }
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
        }
    }
    
    // MARK: Private
    
    @State private var error: AnswerQuestionViewModel.AnswerQuestionError? = nil
    @EnvironmentObject private var state: LandingState
    
    private let viewModel = AnswerQuestionViewModel()
    
}

struct AnswerQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerQuestionView()
            .environmentObject(LandingState())
            .background(Color.gray)
    }
}
