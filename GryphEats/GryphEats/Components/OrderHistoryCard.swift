//
//  OrderHistoryCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-24.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderHistoryCard

struct OrderHistoryCard: View {
    
    // MARK: Lifecycle
    
    init(order: Order) {
        self.order = order
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Mom's Kitchen")
                        .bold()
                        .padding(.bottom, 5)
                    Text("#" + String(order.id))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("$9.99")
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    Text("Sept 22, 2019")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }.padding(.bottom, 5)
                .padding([.horizontal, .top])
            
            HStack {
                Spacer()
                Image(systemName: orderStatusIcon)
                Text(order.status.asString)
                    .font(.caption)
            }.foregroundColor(orderStatusColor)
                .padding([.trailing, .bottom])
        }.contentShape(Rectangle()) //Not sure why this is need but without it, tap gestures are not recognized if the
            // tap occurs on a `Spacer`: https://stackoverflow.com/a/58138763
            .background(Color.white)
            .cornerRadius(5)
            .padding([.horizontal, .top])
            .shadow(radius: 2)
    }
    
    // MARK: Private
    
    private let order: Order
    
    private var orderStatusIcon: String {
        switch order.status {
        case .new:
            return "staroflife"
        case .inProgress:
            return "clock"
        case .readyForPickup:
            return "person.crop.circle"
        case .pickedUp:
            return "checkmark.circle"
        }
    }
    
    private var orderStatusColor: Color {
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

struct OrderHistoryCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            OrderHistoryCard(order: Order(id: 0, customer: Customer(name: "Domenic Bianchi"), status: .new, time: "12:00pm"))
            OrderHistoryCard(order: Order(id: 0, customer: Customer(name: "Domenic Bianchi"), status: .readyForPickup, time: "12:00pm"))
            OrderHistoryCard(order: Order(id: 0, customer: Customer(name: "Domenic Bianchi"), status: .inProgress, time: "12:00pm"))
            OrderHistoryCard(order: Order(id: 0, customer: Customer(name: "Domenic Bianchi"), status: .pickedUp, time: "12:00pm"))
            Spacer()
        }.background(Color.lightGray)
            .edgesIgnoringSafeArea(.all)
    }
}
