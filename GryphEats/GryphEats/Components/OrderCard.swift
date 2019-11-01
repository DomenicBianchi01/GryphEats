//
//  OrderCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-02.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderCard

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
    
    init(order: Order, enableShadow: Bool = true, isCollapsable: Bool = true, fillSpace: Bool = false) {
        self.order = order
        self.enableShadow = enableShadow
        self.isCollapsable = isCollapsable
        self.fillSpace = fillSpace
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
                    Text(order.timePlaced)
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
                    Group() {
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
                    }.disabled(isCollapsable)
                        .opacity(isCollapsable ? 1 : 0)
                }
                if visibility == .expanded {
                    Text("List of food items")
                        .font(.system(size: 12))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                }
            }.layoutPriority(1) //Why do we need this?
        }.background(fillSpace ? Color(red: 235/255, green: 235/255, blue: 235/255) : Color(red: 235/255, green: 235/255, blue: 235/255))
            .cornerRadius(fillSpace ? 10 : 10)
            .padding(.horizontal, fillSpace ? 0 : 15)
            .padding([.top, .bottom], fillSpace ? 0 : 10)
            .shadow(radius: enableShadow ? 10 : 0)
    }
    
    // MARK: Private
    
    @State private var visibility: Visibility = .collapsed
    
    @ObservedObject private var order: Order
    private var enableShadow: Bool
    private var isCollapsable: Bool
    private var fillSpace: Bool
    
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

struct OrderCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            OrderCard(order: Order(id: 0, customer: Customer(name: "Domenic Bianchi"), status: .new, timePlaced: "12:00pm"))
            OrderCard(order: Order(id: 1, customer: Customer(name: "Scott Riva"), status: .inProgress, timePlaced: "12:00pm"))
            OrderCard(order: Order(id: 2, customer: Customer(name: "Matthew Bebis"), status: .readyForPickup, timePlaced: "12:00pm"))
            OrderCard(order: Order(id: 3, customer: Customer(name: "Shu"), status: .pickedUp, timePlaced: "12:00pm"))
            Spacer()
        }.background(Color(red: 250/255, green: 250/255, blue: 250/255))
            .edgesIgnoringSafeArea(.all)
    }
}
