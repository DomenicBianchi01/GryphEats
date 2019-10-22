//
//  PaymentInfoTextField.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-17.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - PaymentInfoTextField

struct PaymentInfoTextField: View {
    
    // MARK: DisplayMode
    
    enum DisplayMode: Equatable {
        case basic
        case creditCardNumber
        case question(info: String)
    }
    
    // MARK: SubtitleDisplayMode
    
    enum SubtitleDisplayMode {
        case hidden
        case visible(text: String)
    }
    
    // MARK: CardProvider
    
    //TODO: Move this enum somewhere else (doesn't totally belong in this struct)
    enum CardProvider: Int {
        case visa = 4
        case mastercard = 5
        
        fileprivate var imageName: String {
            switch self {
            case .visa:
                return "visaLogo"
            case .mastercard:
                return "mastercardLogo"
            }
        }
    }
    
    // MARK: Lifecycle
    
    init(
        displayMode: DisplayMode = .basic,
        subtitleDisplayMode: SubtitleDisplayMode = .hidden,
        header: String,
        placeholder: String,
        text: Binding<String>,
        editingChanged: @escaping (Bool) -> Void = { _ in },
        commit: @escaping () -> Void = { })
    {
        self.displayMode = displayMode
        self.subtitleDisplayMode = subtitleDisplayMode
        self.header = header
        self.placeholder = placeholder
        self.editingChanged = editingChanged
        self.commit = commit
        self._text = text
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .padding(.horizontal)
            
            // `TextField` currently does not support changing the color of the placeholder text. Therefore, we need
            // to manually add a custom placeholder label when the text field is empty.
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color(red: 230/255, green: 230/255, blue: 230/255))
                    .frame(height: 50)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.secondary, lineWidth: 0.5)
                )
                
                textField
            }.padding(.horizontal)
            
            subtitle
        }.alert(isPresented: $showQuestionDialog) {
            var message = ""
            
            if case let .question(text) = displayMode {
                message = text
            }
            
            return Alert(title: Text(header), message: Text(message), dismissButton: .default(Text("Dismiss")))
        }
    }
    
    // MARK: Private
    
    @Binding var text: String
    @State var showQuestionDialog = false
    
    private let displayMode: DisplayMode
    private let subtitleDisplayMode: SubtitleDisplayMode
    
    private let header: String
    private let placeholder: String
    
    private let editingChanged: (Bool) -> Void
    private let commit: () -> Void
    
    private var textField: AnyView {
        let group = ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .lineLimit(1)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .lineLimit(1)
                .font(.system(size: 14))
        }.padding(.horizontal, 15)
        switch displayMode {
        case .basic:
            return AnyView(group)
        case .creditCardNumber:
            let image: Image
            
            if let firstCharacter = text.first,
                let firstInteger = Int(String(firstCharacter)),
                let cardProvider = CardProvider(rawValue: firstInteger)
            {
                image = Image(cardProvider.imageName)
                    .resizable()
            } else {
                image = Image(systemName: "creditcard.fill")
            }
            
            return AnyView(Group {
                image
                    .foregroundColor(.secondary)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(.leading, 5)
                group
                    .padding(.leading, 35)
            })
        case .question:
            return AnyView(HStack(spacing: 0) {
                group
                Button(action: {
                    self.showQuestionDialog = true
                }) {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.black)
                }.padding()
            })
        }
    }
    
    private var subtitle: AnyView? {
        guard !text.isEmpty, case let .visible(subtitleText) = subtitleDisplayMode else {
            return nil
        }
        
        return AnyView(Text(subtitleText)
            .font(.caption)
            .foregroundColor(.guelphRed)
            .padding(.horizontal))
    }
}

struct PaymentInfoTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            PaymentInfoTextField(
                displayMode: .creditCardNumber,
                subtitleDisplayMode: .visible(text: "A subtitle"),
                header: "Card Number",
                placeholder: "Placeholder",
                text: .constant(""))
            
            HStack {
                PaymentInfoTextField(
                    displayMode: .question(info: "Some answer"),
                    header: "CCV",
                    placeholder: "Placeholder",
                    text: .constant(""))
                PaymentInfoTextField(
                    displayMode: .question(info: "Some answer"),
                    header: "CCV",
                    placeholder: "Placeholder",
                    text: .constant(""))
            }
            Spacer()
        }.background(Rectangle()
            .fill(Color.lightGray)
            .edgesIgnoringSafeArea(.all))
    }
}
