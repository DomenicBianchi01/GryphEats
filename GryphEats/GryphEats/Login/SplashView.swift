//
//  SplashView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-03.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - SplashView

struct SplashView: View {
    
    // MARK: Internal
    
    var body: some View {
        HStack {
            if state.state == .login {
                LoginView().transition(.leftSlide)
            } else if state.state == .info {
                RegisterView().transition(state.previousState == .security ? .leftSlide : .rightSlide)
            } else if state.state == .security {
                SecurityQuestionView().transition(.rightSlide)
            }
        }.background(Rectangle()
            .fill(LinearGradient(
                gradient: Gradient(colors: [.guelphRed, .guelphYellow]),
                startPoint: .top,
                endPoint: .bottom))
            .edgesIgnoringSafeArea(.all))
    }
    
    // MARK: Private

    @EnvironmentObject private var state: RegistrationState

}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView().environmentObject(RegistrationState())
    }
}
