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
    
    init(isAnimating: Binding<Bool> = .constant(true), style: UIActivityIndicatorView.Style, color: UIColor? = nil) {
        self._isAnimating = isAnimating
        self.style = style
        self.color = color
    }
    
    // MARK: Internal
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        
        if let color = color {
           view.color = color
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
    
    // MARK: Private
    
    @Binding private var isAnimating: Bool
    private let style: UIActivityIndicatorView.Style
    private let color: UIColor?
    
}

// MARK: - ActivityIndicatorView

struct ActivityIndicatorView: View {
    
    // MARK: Lifecycle
    
    init(color: UIColor? = nil) {
        self.color = color
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            Spacer()
            ActivityIndicator(style: .large, color: color)
            Spacer()
        }
    }
    
    // MARK: Private
    
    private let color: UIColor?
    
}
