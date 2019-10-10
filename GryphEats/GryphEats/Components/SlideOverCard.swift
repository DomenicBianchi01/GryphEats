//
//  SlideOverCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-09.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// Inspiration provided from https://www.mozzafiller.com/posts/swiftui-slide-over-card-like-maps-stocks

// MARK: - SlideOverCar

struct SlideOverCard<V: View> : View {
    
    // MARK: Lifecycle
    
    init(content: @escaping () -> V) {
        self.content = content
    }
    
    // MARK: Internal
    
    var body: some View {
        let drag = DragGesture().updating($dragState) { drag, state, _ in
            state = .dragging(translation: drag.translation)
        }.onEnded(onDragEnded)
        
        return VStack {
            Handle()
            Button(action: {}) {
                HStack {
                    // SwiftUI Bug: Wrapping this button around a GeometryReader causes a lot of vertical whitespace to
                    // randomly get added to the frame of the button (without any code that modifies the frame). As a
                    // result, we have to use Spacers for now.
                    Spacer()
                    Text("Add To Order").foregroundColor(.black).bold()
                    Spacer()
                }
            }.padding(.vertical)
                .background(Color.guelphYellow)
                .cornerRadius(5)
                .padding([.horizontal, .bottom], 30)
            // ^^^ SwiftUI Bug: Horizontal padding only gets added after applying the background. Vertical padding only
            // gets applied if it is added before the background. This is really weird...
            
            content()
        }.frame(height: UIScreen.main.bounds.height)
            .background(Color.white)
            .cornerRadius(15)
            .offset(y: offset)
            .animation(dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300, damping: 20, initialVelocity: 10))
            .gesture(drag)
    }
    
    // MARK: Private
    
    @GestureState private var dragState: DragState = .inactive
    @State private var position: CGFloat = UIScreen.main.bounds.height - 190
    
    private let content: () -> V
    private let minimumOffset: CGFloat = 190
    private let maximumHeight: CGFloat = 100
    
    private func onDragEnded(drag: DragGesture.Value) {
        if drag.location.y < maximumHeight {
            position = maximumHeight
        } else {
            position = drag.location.y
        }
    }
    
    private var offset: CGFloat {
        if position + dragState.translation.height > UIScreen.main.bounds.height - minimumOffset {
            // Prevent card from being dragged too LOW
            return UIScreen.main.bounds.height - minimumOffset
        }
        else if position + dragState.translation.height < maximumHeight {
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
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: handleThickness / 2.0)
                .frame(width: 40, height: handleThickness)
                .padding([.horizontal, .top])
                .foregroundColor(.secondary)
            Text("Pull Up To Customize")
                .font(.caption)
                .padding(.bottom)
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: Private
    
    private let handleThickness: CGFloat = 5
    
}

// MARK: SlideOverCard_Previews

struct SlideOverCard_Previews: PreviewProvider {
    static var previews: some View {
        SlideOverCard {
            Text("Test")
        }.background(Color.gray)
    }
}
