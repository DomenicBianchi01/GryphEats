//
//  OrderStatusBar.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-31.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderStatusBar

struct OrderStatusBar: View {
    
    // MARK: Lifecycle
    
    init(status: Order.Status, action: @escaping () -> Void) {
        self.status = status
        self.action = action
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(Order.Status.allCases) { stepStatus in
                    self.orderStatusStepView(for: stepStatus)
                }
            }
            
            if status == .new {
                ActionButton(
                    text: "Cancel Order",
                    backgroundColor: .guelphRed,
                    foregroundColor: .white)
                {
                    self.action()
                }.padding(.top, 30)
            } else if status == .cancelled {
                Text("Order was cancelled")
                    .bold()
                    .foregroundColor(.guelphRed)
                    .padding([.horizontal, .top])
            }
        }
    }
    
    // MARK: Private
    
    private let status: Order.Status
    private let action: () -> Void
    
    private func orderStatusStepView(for stepStatus: Order.Status) -> OrderStatusStepView {
        var barStyle: OrderStatusStepView.BarStyle = .full
        
        if stepStatus.rawValue == 0 {
            barStyle = .trailing
        } else if stepStatus.rawValue == Order.Status.allCases.count - 1 {
            barStyle = .leading
        }
        
        return OrderStatusStepView(
            step: stepStatus.rawValue + 1,
            text: stepStatus.asString,
            barStyle: barStyle,
            state: status == .cancelled ? .cancelled : .active,
            isFirstHalfComplete: self.status.rawValue >= stepStatus.rawValue,
            isSecondHalfComplete: self.status.rawValue > stepStatus.rawValue)
    }
}

struct OrderStatusBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OrderStatusBar(status: .new, action: {})
            OrderStatusBar(status: .inProgress, action: {})
            OrderStatusBar(status: .readyForPickup, action: {})
            OrderStatusBar(status: .pickedUp, action: {})
            OrderStatusBar(status: .cancelled, action: {})
        }
    }
}
