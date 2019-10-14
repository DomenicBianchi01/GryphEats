//
//  BadgeButton.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-14.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - BadgeButton

struct BadgeButton<V: View>: View {
    
    // MARK: Lifecycle
    
    init(
        badgeNumber: Int = 0,
        action: @escaping () -> Void,
        content: @escaping () -> V)
    {
        self.badgeNumber = badgeNumber
        self.action = action
        self.content = content
    }
    
    // MARK: Internal
    
    var body: some View {
        ZStack {
            Button(action: action) {
                content()
            }
            
            if badgeNumber > 0 {
                Group {
                    Circle().fill(Color.red)
                    Text(String(badgeNumber))
                        .font(.system(size: 11))
                        .foregroundColor(.white)
                }.frame(width: 15, height: 15)
                    .offset(x: 10, y: -10)
            }
        }
    }
    
    // MARK: Private
    
    private let action: () -> Void
    private let content: () -> V
    private let badgeNumber: Int
    
}

struct BadgeButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BadgeButton(action: {}) {
                Image(systemName: "cart")
                    .foregroundColor(.black)
                    .padding()
            }
            BadgeButton(badgeNumber: 1, action: {}) {
                Image(systemName: "cart")
                    .foregroundColor(.black)
                    .padding()
            }
        }
    }
}

