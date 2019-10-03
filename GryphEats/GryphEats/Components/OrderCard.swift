//
//  OrderCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-02.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct OrderCard: View {
    
    // MARK: Visibility
    
    enum Visibility {
        case collapsed
        case expanded
        
        // MARK: Fileprivate
        
        fileprivate mutating func toggle() {
            switch self {
            case .collapsed:
                self = .expanded
            case .expanded:
                self = .collapsed
            }
        }
    }
    
    // MARK: Lifecycle
    
    init(order: Order) {
        self.order = order
    }
    
    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(orderStatusToColor())
                .frame(width: 10)
            VStack(alignment: .leading) {
                Text(order.customer.name)
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                HStack {
                    Image(systemName: "clock")
                        .padding(.leading, 20)
                        .foregroundColor(.gray)
                    Text(order.time + " (4 minutes ago)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.trailing, 20)
                }
                Divider()
                    .padding(.horizontal, 20)
                HStack {
                    Text("1 Item")
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.visibility.toggle()
                        }
                    }) {
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(visibility == .expanded ? 180 : 0))
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                if visibility == .expanded {
                    Text("List of food items")
                        .font(.system(size: 12))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                }
            }.layoutPriority(1) //Why do we need this?
        }.background(Color(red: 235/255, green: 235/255, blue: 235/255))
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .padding([.top, .bottom], 10)
            .shadow(radius: 10)
    }
    
    // MARK: Private
    
    @State private var visibility: Visibility = .collapsed
    
    private var order: Order
    
    private func orderStatusToColor() -> Color {
        switch order.status {
        case .new:
            return .red
        case .inProgress:
            return .yellow
        case .readyForPickup:
            return .green
        case .pickedUp:
            return .gray
        }
    }
}

#if DEBUG
struct OrderCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            OrderCard(order: Order(customer: Customer(name: "Domenic Bianchi"), status: .new, time: "12:00pm"))
            OrderCard(order: Order(customer: Customer(name: "Scott Riva"), status: .inProgress, time: "12:00pm"))
            OrderCard(order: Order(customer: Customer(name: "Matthew Bebis"), status: .readyForPickup, time: "12:00pm"))
            OrderCard(order: Order(customer: Customer(name: "Shu"), status: .pickedUp, time: "12:00pm"))
            Spacer()
        }.background(Color(red: 250/255, green: 250/255, blue: 250/255))
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
