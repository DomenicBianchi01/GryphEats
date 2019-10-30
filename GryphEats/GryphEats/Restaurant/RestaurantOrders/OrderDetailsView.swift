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
                    self.headerCentent
                }
            } else {
                HStack(alignment: .top, spacing: 20) {
                    self.headerCentent
                }
            }
            Divider()
            List (order.foodItems) { foodItem in
                MealRow(foodItem: foodItem)
            }
        }.padding(.all)
    }
    
    private var headerCentent: AnyView {
        return AnyView(
            Group {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(order.customer.name).font(Font.custom("Roboto-Bold", size: 28))
                        .lineLimit(1)
                    Text("Order placed at " + order.time).font(Font.custom("Roboto-Regular", size: 24)).scaledToFill()
                        .lineLimit(1)
                }
                if ( UIDevice.current.userInterfaceIdiom == .pad ) {
                    Spacer()
                }
                HStack() {
                    CircularButton(
                        text: Text(continueButtonText).font(Font.custom("Roboto-Light", size: 22)),
                        backgroundColor: continueButtonColor,
                        foregroundColor: .black) {
                            self.continueOrder()
                    }.padding(.trailing)
                    CircularButton(
                        text: Text(exitButtonText).font(Font.custom("Roboto-Light", size: 22)),
                        backgroundColor: exitButtonColor,
                        foregroundColor: .black) {
                            self.backOrder()
                    }.padding(.trailing).disabled(false)
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
            updateOrder(orderID: String(order.id), status: .inprogress)
        case .inProgress:
            order.status = .readyForPickup
            updateOrder(orderID: String(order.id), status: .ready)
        case .readyForPickup:
            order.status = .pickedUp
            updateOrder(orderID: String(order.id), status: .pickedup)
        case .pickedUp:
            order.status = .pickedUp
        }
    }
    
    private func updateOrder(orderID: String, status: OrderStatus) {
        self.viewModel.updateOrder(orderID: orderID, status: status) { result in
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
        case .new: order.status = .readyForPickup
        case .inProgress: order.status = .new
        case .readyForPickup: order.status = .inProgress
        case .pickedUp: order.status = .new
        }
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
        let colors: [Color] = [.red, .red, .gray, .gray]
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
