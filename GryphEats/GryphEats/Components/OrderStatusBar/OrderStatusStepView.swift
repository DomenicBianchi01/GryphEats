//
//  OrderStatusStepView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-31.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderStatusStepView

struct OrderStatusStepView: View {
    
    // MARK: BarStyle
    
    enum BarStyle {
        case full
        case leading
        case trailing
    }
    
    // MARK: State
    
    enum State {
        case active
        case cancelled
    }
    
    // MARK: Lifecycle
    
    init(
        step: Int,
        text: String,
        barStyle: BarStyle = .full,
        state: State = .active,
        isFirstHalfComplete: Bool,
        isSecondHalfComplete: Bool)
    {
        self.step = step
        self.text = text
        self.barStyle = barStyle
        self.state = state
        self.isFirstHalfComplete = isFirstHalfComplete
        self.isSecondHalfComplete = isSecondHalfComplete
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            ZStack {
                rectangles
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(circleColor)
                    .overlay(Circle().stroke(circleBorderColor, lineWidth: 2))
                
                Text(String(step)).font(.system(size: 14))
                    .foregroundColor(stepColor)
            }
            Text(text)
                .font(.system(size: 10))
                .fixedSize(horizontal: true, vertical: false)
        }
    }
    
    // MARK: Private
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    private let step: Int
    private let text: String
    private let barStyle: BarStyle
    private let state: State
    private let isFirstHalfComplete: Bool
    private let isSecondHalfComplete: Bool
    
    private var circleColor: Color {
        if state == .cancelled {
            return .guelphRed(for: colorScheme)
        } else if isFirstHalfComplete && isSecondHalfComplete {
            return .tabBarBackground(for: colorScheme)
        } else if isFirstHalfComplete {
            return .green
        }
        
        return .tabBarBackground(for: colorScheme)
    }
    
    private var circleBorderColor: Color {
        if state == .cancelled {
            return .guelphRed(for: colorScheme)
        } else if isFirstHalfComplete {
            return .green
        }
        
        return .gray
    }
    
    private var stepColor: Color {
        if state == .cancelled {
            return .guelphRed(for: colorScheme)
        } else if isFirstHalfComplete && isSecondHalfComplete {
            return .darkModeBlack(for: colorScheme)
        } else if isFirstHalfComplete {
            return .lightGray(for: colorScheme)
        }
        
        return .darkModeBlack(for: colorScheme)
    }
    
    private var rectangles: AnyView {
        let leadingRectangle = Rectangle()
            .frame(height: 2)
            .padding(.top, 2)
        let trailingRectangle = Rectangle()
            .frame(height: 2)
            .padding(.top, 2)
        
        switch barStyle {
        case .full:
            let leadingColor: Color
            let trailingColor: Color
            
            if state == .cancelled {
                leadingColor = .guelphRed(for: colorScheme)
                trailingColor = .guelphRed(for: colorScheme)
            } else {
                if isFirstHalfComplete {
                    leadingColor = .green
                } else {
                    leadingColor = .gray
                }
                
                if isSecondHalfComplete {
                    trailingColor = .green
                } else {
                    trailingColor = .gray
                }
            }
            
            return AnyView(HStack {
                leadingRectangle.foregroundColor(leadingColor)
                trailingRectangle.foregroundColor(trailingColor)
            })
        case .leading:
            let leadingColor: Color
            
            if state == .cancelled {
                leadingColor = .guelphRed(for: colorScheme)
            } else {
                if isFirstHalfComplete {
                    leadingColor = .green
                } else {
                    leadingColor = .gray
                }
            }
            return AnyView(HStack {
                leadingRectangle.foregroundColor(leadingColor)
                trailingRectangle.foregroundColor(.clear)
            })
        case .trailing:
            let trailingColor: Color
            
            if state == .cancelled {
                trailingColor = .guelphRed(for: colorScheme)
            } else {
                if isSecondHalfComplete {
                    trailingColor = .green
                } else {
                    trailingColor = .gray
                }
            }
            
            return AnyView(HStack {
                leadingRectangle.foregroundColor(.clear)
                trailingRectangle.foregroundColor(trailingColor)
            })
        }
    }
}

struct OrderStatusStepView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OrderStatusStepView(
                step: 1,
                text: "Order Placed",
                isFirstHalfComplete: true,
                isSecondHalfComplete: false)
            OrderStatusStepView(
                step: 1,
                text: "Order Placed",
                barStyle: .leading,
                isFirstHalfComplete: true,
                isSecondHalfComplete: false)
            OrderStatusStepView(
                step: 1,
                text: "Order Placed",
                barStyle: .trailing,
                isFirstHalfComplete: true,
                isSecondHalfComplete: false)
            OrderStatusStepView(
            step: 1,
            text: "Order Placed",
            barStyle: .trailing,
            state: .cancelled,
            isFirstHalfComplete: true,
            isSecondHalfComplete: false)
        }
    }
}
