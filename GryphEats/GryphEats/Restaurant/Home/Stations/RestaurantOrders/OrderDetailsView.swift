//
//  OrderDetailsView.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/10/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import QGrid

struct OrderDetailsView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(){
                Spacer()
            }.padding(.leading)
            
            if ( UIDevice.current.userInterfaceIdiom == .phone ) {
                VStack(alignment: .leading, spacing: 20) {
                    self.headerContent
                }
            } else {
                HStack(alignment: .top, spacing: 20) {
                    self.headerContent
                }
            }
            Divider()
            VStack(alignment: .leading, spacing: 14) {
                Text("Additional Info:")
                    .font(Font.custom("Roboto-Bold", size: 28))
                    .foregroundColor(Color.secondary)
                Text(order.specialInstructions ?? "").font(Font.custom("Roboto-Regular", size: 28)).padding(.leading).foregroundColor(Color.primary)
            }.padding(.leading)
            Divider()
            List(order.items, id: \.foodItem.id) { restaurantFoodItem in
                MealRow(foodItem: restaurantFoodItem.foodItem)
            }
        }.padding(.all)
    }
    
    private var headerContent: AnyView {
        return AnyView(
            Group {
                VStack(alignment: .leading, spacing: 10) {
                    Text(order.customer.name)
                        .font(Font.custom("Roboto-Bold", size: 28))
                        .lineLimit(1)
                    Text("Order placed at " + order.timePlacedString())
                        .font(Font.custom("Roboto-Regular", size: 24))
                        .scaledToFill()
                        .lineLimit(1)
                }
                if ( UIDevice.current.userInterfaceIdiom == .pad ) {
                    Spacer()
                }
                HStack() {
                    CircularButton(
                        text: Text(exitButtonText).font(Font.custom("Roboto-Light", size: 22)),
                        backgroundColor: exitButtonColor,
                        foregroundColor: .black) {
                            self.backOrder()
                    }.padding(.trailing).disabled(!isNew).opacity(isNew ? 1 : 0)
                    CircularButton(
                        text: Text(continueButtonText).font(Font.custom("Roboto-Light", size: 22)),
                        backgroundColor: continueButtonColor,
                        foregroundColor: .black) {
                            self.continueOrder()
                    }.padding(.trailing)
                }
            }
        )
    }
    
    @ObservedObject var order: Order
    @ObservedObject private var viewModel: OrderDetailsViewModel = OrderDetailsViewModel()
    
    private func continueOrder() {
        switch order.status {
        case .new:
            order.status = .inProgress
            update(order: order, status: .inprogress)
        case .inProgress:
            order.status = .readyForPickup
            update(order: order, status: .ready)
        case .readyForPickup:
            order.status = .pickedUp
            update(order: order, status: .pickedup)
        case .pickedUp:
            order.status = .pickedUp
        default:
            return
        }
    }
    
    private func update(order: Order, status: OrderStatus) {
        self.viewModel.update(order: order, status: status) { result in
            switch result {
            case .success:
                print("Success")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func backOrder() {
        switch order.status {
        case .new:
            order.status = .readyForPickup
        case .inProgress:
            order.status = .new
        case .readyForPickup:
            order.status = .inProgress
        case .pickedUp:
            order.status = .new
        default:
            return
        }
    }
    
    private var isNew: Bool {
        return order.status.rawValue == 0 ? true : false
    }
    
    private var continueButtonColor: Color {
        let colors: [Color] = [.blue, .guelphYellow, .green, .gray]
        return colors[order.status.rawValue]
    }
    
    private var continueButtonText: String {
        let text = ["Begin Order", "Complete Order", "Confirm Pick Up", "Order Recieved"]
        return text[order.status.rawValue]
    }
    
    private var exitButtonColor: Color {
        let colors: [Color] = [.gray, .gray, .gray, .gray]
        return colors[order.status.rawValue]
    }
    
    private var exitButtonText: String {
        let text = ["Decline Order", "Cancel Order", "Order Complete", "Order Recieved"]
        return text[order.status.rawValue]
    }
}
//
//struct OrderDetailsView_preview: PreviewProvider {
//    static var previews: some View {
//        OrderDetailsView()
//    }
//}
