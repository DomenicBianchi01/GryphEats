//
//  CustomTextField.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-03.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CustomTextField

struct CustomTextField: View {
    
    // MARK: Lifecycle
    
    init(
        header: String,
        subtitle: String? = nil,
        placeholder: String,
        text: Binding<String>,
        isSecure: Bool = false,
        editingChanged: @escaping (Bool) -> Void = { _ in },
        commit: @escaping () -> Void = { },
        headerFontSize: CGFloat = 12,
        textFieldFontSize: CGFloat = 16)
    {
        self.header = header
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.editingChanged = editingChanged
        self.commit = commit
        self._text = text //https://stackoverflow.com/a/56975728
        self.headerFontSize = headerFontSize
        self.textFieldFontSize = textFieldFontSize
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header.uppercased())
                .font(.system(size: headerFontSize))
                .padding(.bottom, 0)
            
            // `TextField` currently does not support changing the color of the placeholder text. Therefore, we need
            // to manually add a custom placeholder label when the text field is empty.
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                }
                
                if isSecure {
                    SecureField("", text: $text, onCommit: commit)
                        .font(.system(size: textFieldFontSize))
                } else {
                    TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                        .font(.system(size: textFieldFontSize))
                }
            }

            Rectangle().frame(height: 1)
            
            //SwiftUI does not support `if-let` yet.
            if subtitle != nil {
                Text(subtitle!).font(.caption)
            }
        }.frame(maxWidth: 400)
    }
    
    // MARK: Private
    
    @Binding var text: String
    
    private let header: String
    private let subtitle: String?
    private let placeholder: String
    private let isSecure: Bool
    
    private let editingChanged: (Bool) -> Void
    private let commit: () -> Void
    
    private let headerFontSize: CGFloat
    private let textFieldFontSize: CGFloat

}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(
            header: "Email".uppercased(),
            placeholder: "Placeholder",
            text: .constant("Please enter your email"))
    }
}
