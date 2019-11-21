//
//  SlideOverCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-09.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// Inspiration provided from https://www.mozzafiller.com/posts/swiftui-slide-over-card-like-maps-stocks

// MARK: - SlideOverCard

struct SlideOverCard<V: View>: View {
    
    // MARK: Lifecycle
    
    init(handleText: String, isSlidingDisabled: Bool = true, content: @escaping () -> V) {
        self.handleText = handleText
        self.isSlidingDisabled = isSlidingDisabled
        self.content = content
    }
    
    // MARK: Internal
    
    var body: some View {
        let drag = DragGesture().updating($dragState) { drag, state, _ in
            state = .dragging(translation: drag.translation)
        }.onEnded(onDragEnded)
        
        let view = VStack {
            if !isSlidingDisabled {
                Handle(text: handleText)
            }
            
            content().padding(.top, isSlidingDisabled ? 20 : 0)
            
            if isSlidingDisabled {
                Spacer()
            }
        }.frame(height: UIScreen.main.bounds.height)
            .background(Color.cardBackground(for: colorScheme))
            .cornerRadius(15)
            .offset(y: offset)
            .animation(dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300, damping: 20, initialVelocity: 10))
        
        if isSlidingDisabled {
            return AnyView(view)
        } else {
            return AnyView(view.gesture(drag))
        }
    }
    
    // MARK: Private
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @GestureState private var dragState: DragState = .inactive
    @State private var position: CGFloat = UIScreen.main.bounds.height - 150
    
    private let content: () -> V
    private let handleText: String
    private let isSlidingDisabled: Bool
    
    private let maximumHeight: CGFloat = 145
    
    private var minimumOffset: CGFloat {
        return isSlidingDisabled ? 100 : 150
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        if drag.location.y < maximumHeight {
            position = maximumHeight
        } else {
            position = drag.location.y
        }
    }
    
    private var offset: CGFloat {
        if isSlidingDisabled {
            return UIScreen.main.bounds.height - minimumOffset
        }
        
        if position + dragState.translation.height > UIScreen.main.bounds.height - minimumOffset {
            // Prevent card from being dragged too LOW
            return UIScreen.main.bounds.height - minimumOffset
        } else if position + dragState.translation.height < maximumHeight {
            // Prevent card from being dragged too HIGHT
            return maximumHeight
        } else {
            return position + dragState.translation.height
        }
    }
}

// MARK: - DragState

private enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    // MARK: Internal
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

// MARK: - Handle

private struct Handle: View {
    
    // MARK: Lifecycle
    
    init(text: String) {
        self.text = text
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: handleThickness / 2.0)
                .frame(width: 40, height: handleThickness)
                .padding([.horizontal, .top])
            Text(text)
                .font(.caption)
                .padding(.bottom)
        }.foregroundColor(.secondary)
    }
    
    // MARK: Private
    
    private let handleThickness: CGFloat = 5
    private let text: String
    
}

// MARK: - SlideOverCard_Previews

struct SlideOverCard_Previews: PreviewProvider {
    static var previews: some View {
        SlideOverCard(handleText: "Pull Up To Customize") {
            Text("Test")
        }.background(Color.gray)
    }
}
