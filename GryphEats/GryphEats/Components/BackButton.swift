//
//  BackButton.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - BackButton

struct BackButton: View {
    
    // MARK: Lifecycle
    
    init(color: Color = .white, action: @escaping () -> Void) {
        self.color = color
        self.action = action
    }
    
    // MARK: Internal
    
    var body: some View {
        HStack {
            Button(action: action) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }.foregroundColor(color)
                    .padding()
            }
            Spacer()
        }
    }
    
    // MARK: Private
    
    private let action: () -> Void
    private let color: Color
    
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(action: {})
    }
}
