//
//  ActionButton.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - ActionButton

struct ActionButton: View {
    
    // MARK: Lifecycle
    
    init(
        text: String,
        backgroundColor: Color = .guelphYellow,
        foregroundColor: Color = .black,
        action: @escaping () -> Void)
    {
        self.text = text
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.action = action
    }
    
    // MARK: Internal
    
    var body: some View {
        // SwiftUI Bug: Wrapping this button around a GeometryReader causes a lot of vertical
        //whitespace to randomly get added to the frame of the button (without any code that
        // modifies the frame). As a result, we have to use Spacers for now.
        Button(action: action) {
            HStack {
                Spacer()
                Text(text)
                    .foregroundColor(foregroundColor)
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
            }
        }.padding(.vertical, 15)
            .background(backgroundColor)
            .cornerRadius(5)
            .padding(.horizontal)
        // ^^^ SwiftUI Bug: Horizontal padding only gets added after applying the background. Vertical
        // padding only gets applied if it is added before the background. This is really weird...
    }
    
    // MARK: Private
    
    private let text: String
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let action: () -> Void

}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(text: "Continue", action: {})
    }
}
