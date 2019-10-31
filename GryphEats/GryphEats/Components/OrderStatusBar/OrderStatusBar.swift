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
                    
                }.padding(.top)
            }
        }
    }
    
    // MARK: Private
    
    private let status: Order.Status
    
    private func orderStatusStepView(for stepStatus: Order.Status) -> OrderStatusStepView {
        OrderStatusStepView(
            text: stepStatus.asString,
            isFirstHalfComplete: self.status.rawValue >= stepStatus.rawValue,
            isSecondHalfComplete: self.status.rawValue > stepStatus.rawValue ||
                Order.Status.allCases.count == self.status.rawValue + 1)
    }
}

struct OrderStatusBar_Previews: PreviewProvider {
    static var previews: some View {
        OrderStatusBar(status: .new)
    }
}
