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
            
            Text("Where was your first trip?")
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
                        if let error = self.state.validateForgotPasswordInput() {
                            self.error = error
                        } else {
                            withAnimation {
                                self.state.state = .resetPassword
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

struct AnswerQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerQuestionView()
            .environmentObject(LandingState())
            .background(Color.gray)
    }
}
