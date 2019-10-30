//
//  RestOrdersViewModel.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/23/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - RestOrdersViewModel

class RestOrdersViewModel: ObservableObject {
    
    init(restID: String) {
        self.restID = restID
    }
    
    // MARK: LoadingState
    
    enum LoadingState {
        case loading
        case loaded([Order])
        case error
    }
    
    @Published var loadingState: LoadingState = .loading
    var restID: String
    
    // MARK: Private
    
    func fetchOrders() {
        self.loadingState = .loading
        
        GraphClient.shared.fetch(query: OrdersByRestQuery(restID: restID)) { result in
            switch result {
            case .success(let data):
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .none
                // US English Locale (en_US)
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
                dateFormatter.amSymbol = "am"
                dateFormatter.pmSymbol = "pm"
                
                var orders: [Order] = []
                
                for order in data.getOrdersByRestaurantId.compactMap({ $0 }) {
                    var foodItems: [FoodItem] = []
                    for orderItem in (order.orderitems?.compactMap({ $0 }))! {
                        foodItems.append(FoodItem(id: Int(orderItem.foodid)!, name: (orderItem.food?.displayname)!, imageName: "Borger", ingredients: []))
                    }
                    let date = order.timeplaced!
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                    let dateParsed = dateFormatter.date(from: date)
                    dateFormatter.dateFormat = "h:mma MMM dd, yyyy"
                    let dateString = dateFormatter.string(from: dateParsed!)
                    orders.append(Order(
                        id: Int(order.orderid)!,
                        customer: Customer(name: "John Doe"),
                        status: .new,
                        time: dateString,
                        foodItems: foodItems
                    ))
                }
                self.loadingState = .loaded(orders)
            case .failure:
                self.loadingState = .error
            }
        }
        
        GraphClient.shared.subscribe(subscription: OrderPlacedSubscription(restaurantID: restID)) { result in
            switch result {
            case .success(let data):
                
                guard let orders2 = data.orderPlaced?.compactMap({ $0 }) else {
                    self.loadingState = .error
                    return
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .none
                // US English Locale (en_US)
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
                dateFormatter.amSymbol = "am"
                dateFormatter.pmSymbol = "pm"
                
                var orders: [Order] = []
                
                for order in orders2.compactMap({ $0 }) {
                    var foodItems: [FoodItem] = []
                    
                    for orderItem in order.orderitems?.compactMap({$0}) ?? [] {
                        foodItems.append(FoodItem(id: Int(orderItem.foodid)!, name: (orderItem.food?.displayname)!, imageName: "Borger", ingredients: []))
                    }
                    let date = order.timeplaced!
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                    let dateParsed = dateFormatter.date(from: date)
                    dateFormatter.dateFormat = "h:mma MMM dd, yyyy"
                    let dateString = dateFormatter.string(from: dateParsed!)
                    orders.append(Order(
                        id: Int(order.orderid)!,
                        customer: Customer(name: "John Doe"),
                        status: .new,
                        time: dateString,
                        foodItems: foodItems
                    ))
                    
                }
            
                self.loadingState = .loaded(orders)
            case .failure:
                self.loadingState = .error
            }
        }
    }
}
