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
        
        //        let orders:[Order] = [
        //        Order(id: 0, customer: Customer(name: "Domenic Bianchi", mealPlan: nil), status: .new, time: "11:29am", foodItems: [foodItem1]),
        //        Order(id: 1, customer: Customer(name: "Matthew Bebis", mealPlan: nil), status: .new, time: "11:23am", foodItems: [foodItem2]),
        //        Order(id: 2, customer: Customer(name: "Scott Riva", mealPlan: nil), status: .new, time: "11:20am", foodItems: [foodItem1, foodItem2, foodItem4]),
        //        Order(id: 3, customer: Customer(name: "Shuaib Solker", mealPlan: nil), status: .new, time: "11:31am", foodItems: [foodItem1, foodItem2, foodItem3, foodItem4, foodItem5])]
        //
        //        self.loadingState = .loaded(orders)
        
        Apollo.shared.fetch(query: OrdersByRestQuery(restID: restID)) { result in
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
//        Apollo.shared.subscribe(subscription: OrdersByRestQuery(restID: "1")) { result in
//            switch result {
//            case .suc
//            }
//            
//        }

    }
}
