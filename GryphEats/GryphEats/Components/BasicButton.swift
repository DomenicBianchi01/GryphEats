//
//  BasicButton.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-03.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - BasicButton

struct BasicButton: View {
    
    // MARK: Lifecycle
    
    init(
        text: Text,
        backgroundColor: Color,
        foregroundColor: Color,
        minimumWidth: CGFloat = 100,
        action: @escaping () -> Void = { })
    {
        self.text = text
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.minimumWidth = minimumWidth
        self.action = action
    }
    
    // MARK: Internal
    
    var body: some View {
        Button(action: action) {
            text
                .frame(minWidth: minimumWidth)
                .padding()
                .foregroundColor(foregroundColor)
                //.minimumScaleFactor(0.1) //TODO: Possible SwiftUI bug, font is scaling down as small as possible on real devices but working correctly on the simulator
        }.background(backgroundColor)
    }
    
    // MARK: Private
    
    private let action: () -> Void
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let minimumWidth: CGFloat
    private let text: Text

}

struct BasicButton_Previews: PreviewProvider {
    static var previews: some View {
        BasicButton(text: Text("A button"), backgroundColor: .orange, foregroundColor: .blue)
    }
}
