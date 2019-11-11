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
                    // An order object will only contain items from a single restaurant. Not a huge fan of this line
                    // but it'll do for now
                    Text(order.items.first?.restaurantName ?? "")
                        .bold()
                        .padding(.bottom, 5)
                    Text("#" + String(order.id))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(order.total().asDollarString)
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    Text(order.timePlacedString())
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
        }.contentShape(Rectangle()) //Not sure why this is need but without it tap gestures are not recognized if the
            // tap occurs on a `Spacer`: https://stackoverflow.com/a/58138763
            .background(Color.cardBackground(for: colorScheme))
            .cornerRadius(5)
            .padding([.horizontal, .top])
            .shadow(radius: 2)
    }
    
    // MARK: Private
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
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
        case .cancelled:
            return "xmark"
        }
    }
    
    private var orderStatusColor: Color {
        switch order.status {
        case .new, .cancelled:
            return .guelphRed(for: colorScheme)
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
            OrderHistoryCard(order: Order(id: "1", restaurantID: "1", customer: Customer(name: "Domenic Bianchi"), status: .neworder, timePlaced: "12:00pm"))
            OrderHistoryCard(order: Order(id: "1", restaurantID: "1", customer: Customer(name: "Domenic Bianchi"), status: .inprogress, timePlaced: "12:00pm"))
            OrderHistoryCard(order: Order(id: "1", restaurantID: "1", customer: Customer(name: "Domenic Bianchi"), status: .ready, timePlaced: "12:00pm"))
            OrderHistoryCard(order: Order(id: "1", restaurantID: "1", customer: Customer(name: "Domenic Bianchi"), status: .pickedup, timePlaced: "12:00pm"))
            Spacer()
        }.background(Color.lightGray(for: .light))
            .edgesIgnoringSafeArea(.all)
    }
}
