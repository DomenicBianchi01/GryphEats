//
//  ErrorView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - ErrorView

struct ErrorView: View {
    
    // MARK: Lifecycle
    
    init(infoText: String, buttonText: LocalizedStringKey, onTap: @escaping () -> Void) {
        self.infoText = infoText
        self.buttonText = buttonText
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            Spacer()
            Text(infoText)
                .foregroundColor(.secondary)
                .font(.system(size: 12))
                .padding([.horizontal, .bottom])
            ActionButton(text: buttonText, action: onTap)
            Spacer()
        }
    }
    
    // MARK: Private
    
    private let infoText: String
    private let buttonText: LocalizedStringKey
    private let onTap: () -> Void
    
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(infoText: "Whoops!", buttonText: "Try Again") { print("Tapped") }
    }
}
