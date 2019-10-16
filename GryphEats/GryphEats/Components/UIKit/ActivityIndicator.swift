//
//  ActivityIndicator.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: - ActivityIndicator

/// `UIActivityIndicatorView` bridged over to SwiftUI
struct ActivityIndicator: UIViewRepresentable {
    
    // MARK: Lifecycle
    
    init(isAnimating: Binding<Bool> = .constant(true), style: UIActivityIndicatorView.Style) {
        self._isAnimating = isAnimating
        self.style = style
    }
    
    // MARK: Internal
    
    @Binding var isAnimating: Bool

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
    
    // MARK: Private
    
    private let style: UIActivityIndicatorView.Style

}
