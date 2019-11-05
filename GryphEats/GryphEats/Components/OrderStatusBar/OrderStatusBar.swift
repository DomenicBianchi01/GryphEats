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
    
    init(status: Order.Status) {
        self.status = status
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
                    
                }.padding(.top, 30)
            }
        }
    }
    
    // MARK: Private
    
    private let status: Order.Status
    
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
            isFirstHalfComplete: self.status.rawValue >= stepStatus.rawValue,
            isSecondHalfComplete: self.status.rawValue > stepStatus.rawValue)
    }
}

struct OrderStatusBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OrderStatusBar(status: .new)
            OrderStatusBar(status: .inProgress)
            OrderStatusBar(status: .readyForPickup)
            OrderStatusBar(status: .pickedUp)
        }
    }
}
