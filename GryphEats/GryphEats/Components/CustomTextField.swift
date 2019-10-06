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
        header: Text,
        placeholder: Text,
        text: Binding<String>,
        isSecure: Bool = false,
        editingChanged: @escaping (Bool) -> Void = { _ in },
        commit: @escaping () -> Void = { })
    {
        self.header = header
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.editingChanged = editingChanged
        self.commit = commit
        self._text = text //https://stackoverflow.com/a/56975728
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
            header
                .font(.system(size: 12))
                .padding(.bottom, 0)
            
            // `TextField` currently does not support changing the color of the placeholder text. Therefore, we need
            // to manually add a custom placeholder label when the text field is empty.
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    placeholder
                }
                
                if isSecure {
                    SecureField("", text: $text, onCommit: commit)
                    .font(.system(size: 16))
                } else {
                    TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                    .font(.system(size: 16))
                }
            }

            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white)
        }.frame(maxWidth: 400)
    }
    
    // MARK: Private
    
    @Binding var text: String
    
    private let header: Text
    private let placeholder: Text
    private let isSecure: Bool
    
    private let editingChanged: (Bool) -> Void
    private let commit: () -> Void
    
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(
            header: Text("Email".uppercased()),
            placeholder: Text("Placeholder"),
            text: .constant("Please enter your email"))
    }
}
