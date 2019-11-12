//
//  CircularButton.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-03.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CircularButton

struct CircularButton: View {
    
    // MARK: Lifecycle
    
    init(
        text: Text,
        backgroundColor: Color,
        foregroundColor: Color,
        borderColor: Color? = nil,
        action: @escaping () -> Void = { })
    {
        self.button = BasicButton(
            text: text,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            action: action)
        
        self.borderColor = borderColor
    }
    
    // MARK: Internal
    
    var body: some View {
        Group {
            //Doesn't look like SwiftUI supports if-let statements yet
            if borderColor != nil {
                button.overlay(RoundedRectangle(cornerRadius: .infinity).stroke(borderColor!, lineWidth: 2))
            } else {
                button.cornerRadius(.infinity)
            }
        }
    }
    
    // MARK: Private
    
    private let button: BasicButton
    private let borderColor: Color?
    
}

struct CircularButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CircularButton(text: Text("A Button"), backgroundColor: .clear, foregroundColor: .white, borderColor: .white)
            CircularButton(text: Text("A Button"), backgroundColor: .white, foregroundColor: .black)
        }.background(Color.red)
    }
}
