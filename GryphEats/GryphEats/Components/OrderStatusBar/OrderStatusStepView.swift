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
    
    // MARK: Lifecycle
    
    init(text: String, isFirstHalfComplete: Bool, isSecondHalfComplete: Bool) {
        self.text = text
        self.isFirstHalfComplete = isFirstHalfComplete
        self.isSecondHalfComplete = isSecondHalfComplete
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Rectangle().frame(height: 2).padding(.top, 2).foregroundColor(isFirstHalfComplete ? .green : .gray)
                    Rectangle().frame(height: 2).padding(.top, 2).foregroundColor(isSecondHalfComplete ? .green : .gray)
                }
                Circle().frame(width: 30, height: 30).foregroundColor(isFirstHalfComplete ? .green : .gray)
                
                if isFirstHalfComplete {
                    Image(systemName: "checkmark").resizable().frame(width: 12, height: 12).foregroundColor(.white)
                }
            }
            Text(text)
                .font(.system(size: 10))
                .fixedSize(horizontal: true, vertical: false)
        }
    }
    
    // MARK: Private
    
    private let text: String
    private let isFirstHalfComplete: Bool
    private let isSecondHalfComplete: Bool
    
}

struct OrderStatusStepView_Previews: PreviewProvider {
    static var previews: some View {
        OrderStatusStepView(text: "Order Placed", isFirstHalfComplete: true, isSecondHalfComplete: false)
    }
}
