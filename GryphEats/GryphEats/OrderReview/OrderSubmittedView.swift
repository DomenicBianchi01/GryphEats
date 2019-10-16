//
//  OrderSubmittedView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-16.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderSubmittedView

struct OrderSubmittedView: View {
    
    // MARK: Internal
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.green)
                    .padding()
                
                Text("Order Submitted!")
                    .bold()
                    .padding(.bottom, 10)
                
                Text("You will receive a notification when we begin to prepare your order and when it is ready for pickup.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
            }
            Spacer()
        }
    }
}

struct OrderSubmittedView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSubmittedView()
    }
}
