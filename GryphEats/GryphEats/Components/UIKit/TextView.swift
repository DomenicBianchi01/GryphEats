//
//  TextView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-07.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: TextView

/// `UITextView` bridged over to SwiftUI
struct TextView: UIViewRepresentable {
    
    // MARK: Lifecycle
    
    init(text: Binding<String>, isEditable: Bool = true) {
        self._text = text
        self.isEditable = isEditable
    }
    
    // MARK: Internal

    // TODO Bug: Lines do not word wrap automatically for some reason
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = false
        view.isEditable = isEditable
        view.delegate = context.coordinator
        view.textContainer.lineBreakMode = .byWordWrapping
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: Private
    
    @Binding private var text: String
    private let isEditable: Bool
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        // MARK: Lifecycle
        
        init(_ view: TextView) {
            self.parent = view
        }
        
        // MARK: Internal

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        
        // MARK: Private
        
        private let parent: TextView
        
    }
}
