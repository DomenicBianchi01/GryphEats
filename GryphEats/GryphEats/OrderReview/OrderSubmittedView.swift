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
    
    // MARK: Lifecycle
    
    init() {
        self.hapticGenerator.prepare()
    }
    
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
        }.onAppear {
            self.hapticGenerator.generate()
            self.viewModel.registerForNotifications(for: self.loggedInUser)
            
            if case .confirmed(let numberOfOrders) = self.state.state {
                self.numberOfOrders = numberOfOrders
            }
        }.alert(isPresented: .constant(numberOfOrders > 1)) {
            Alert(
                title: Text("Multiple Orders"),
                message: Text("You ordered items from \(numberOfOrders) different restaurants. As a result, your original order has been split into \(numberOfOrders) seperate orders; one for each restaurant. Please note that these orders may be ready for pickup at different times."),
                dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: Private
    
    @EnvironmentObject private var state: OrderReviewState
    @EnvironmentObject private var loggedInUser: User
    @State private var numberOfOrders: Int = 1
    
    private let viewModel = OrderSubmittedViewModel()
    private let hapticGenerator = HapticGenerator(feedbackStyle: .success)
    
}

struct OrderSubmittedView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSubmittedView()
    }
}
