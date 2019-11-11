//
//  LandingView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-03.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - LandingView

struct LandingView: View {
    
    // MARK: Internal
    
    var body: some View {
        HStack {
            if state.state == .login {
                LoginView().transition(.leftSlide)
            } else if state.state == .info {
                RegisterView().transition(state.previousState == .security ? .leftSlide : .rightSlide)
            } else if state.state == .security {
                SecurityQuestionView().transition(.rightSlide)
            } else if state.state == .forgotPassword {
                ForgotPasswordView().transition(.rightSlide)
            } else if state.state == .answerQuestion {
                AnswerQuestionView().transition(.rightSlide)
            } else if state.state == .resetPassword {
                ResetPasswordView().transition(.rightSlide)
            }
        }.background(Rectangle()
            .fill(LinearGradient(
                gradient: Gradient(colors: [.guelphRed(for: .light), .guelphYellow]),
                startPoint: .top,
                endPoint: .bottom))
            .edgesIgnoringSafeArea(.all))
    }
    
    // MARK: Private
    
    @EnvironmentObject private var state: LandingState
    
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().environmentObject(LandingState())
    }
}
