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
    
    // MARK: Lifecycle
    
    init(
        step: Int,
        text: String,
        barStyle: BarStyle = .full,
        isFirstHalfComplete: Bool,
        isSecondHalfComplete: Bool)
    {
        self.step = step
        self.text = text
        self.barStyle = barStyle
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
                    .overlay(Circle().stroke(isFirstHalfComplete ? Color.green : Color.gray, lineWidth: 2))
                
                Text(String(step)).font(.system(size: 14))
                    .foregroundColor(stepColor)
            }
            Text(text)
                .font(.system(size: 10))
                .fixedSize(horizontal: true, vertical: false)
        }
    }
    
    // MARK: Private
    
    private let step: Int
    private let text: String
    private let barStyle: BarStyle
    private let isFirstHalfComplete: Bool
    private let isSecondHalfComplete: Bool
    
    private var circleColor: Color {
        if isFirstHalfComplete && isSecondHalfComplete {
            return .white
        } else if isFirstHalfComplete {
            return .green
        }
        
        return .white
    }
    
    private var stepColor: Color {
        if isFirstHalfComplete && isSecondHalfComplete {
            return .black
        } else if isFirstHalfComplete {
            return .white
        }
        
        return .black
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
            return AnyView(HStack {
                leadingRectangle.foregroundColor(isFirstHalfComplete ? .green : .gray)
                trailingRectangle.foregroundColor(isSecondHalfComplete ? .green : .gray)
            })
        case .leading:
            return AnyView(HStack {
                leadingRectangle.foregroundColor(isFirstHalfComplete ? .green : .gray)
                trailingRectangle.foregroundColor(.clear)
            })
        case .trailing:
            return AnyView(HStack {
                leadingRectangle.foregroundColor(.clear)
                trailingRectangle.foregroundColor(isSecondHalfComplete ? .green : .gray)
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
        }
    }
}
