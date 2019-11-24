//
//  Order.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-02.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - Order

class Order: Items, ObservableObject, Identifiable {
    
    // MARK: Lifecycle
    
    init(
        id: String,
        restaurantName: String? = nil,
        restaurantID: String,
        customer: Customer,
        status: OrderStatus = .neworder,
        timePlaced: String,
        estimatedTimeRemaining: String? = nil,
        paymentType: PaymentType,
        specialInstructions: String? = nil,
        items: [RestaurantFoodItem] = [])
    {
        self.id = id
        self.restaurantName = restaurantName ?? ""
        self.restaurantID = restaurantID
        self.customer = customer
        self.estimatedTimeRemaining = estimatedTimeRemaining
        self.paymentType = paymentType
        self.specialInstructions = specialInstructions
        
        switch status {
        case .neworder, .__unknown:
            self.status = .new
        case .inprogress:
            self.status = .inProgress
        case .ready:
            self.status = .readyForPickup
        case .pickedup:
            self.status = .pickedUp
        case .cancelled:
            self.status = .cancelled
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
        
        self.timePlaced = dateFormatter.date(from: timePlaced) ?? Date()
        
        super.init(items: items)
    }
    
    // MARK: Status
    
    enum Status: Int, Identifiable {
        case new
        case inProgress
        case readyForPickup
        case pickedUp
        case cancelled
        
        // MARK: Internal
        
        /// This does NOT include the `.cancelled` state
        static var trackingCases: [Status] {
            return [.new, .inProgress, .readyForPickup, .pickedUp]
        }
        
        var asString: String {
            switch self {
            case .new:
                return "Order Received"
            case .inProgress:
                return "In Progress"
            case .readyForPickup:
                return "Ready For Pickup"
            case .pickedUp:
                return "Picked Up"
            case .cancelled:
                return "Cancelled"
            }
        }
        
        var isActive: Bool {
            return self == .new || self == .inProgress || self == .readyForPickup
        }
        
        var id: Status { self }
        
    }
    
    // MARK: Internal
    
    @Published var status: Status
    
    let id: String
    let restaurantName: String
    let restaurantID: String
    let customer: Customer
    let timePlaced: Date
    let estimatedTimeRemaining: String?
    let paymentType: PaymentType
    let specialInstructions: String?
    
    func timePlacedString(expanded: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        
        if expanded {
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
        } else {
            dateFormatter.dateStyle = .medium
        }
        
        return dateFormatter.string(from: timePlaced)
    }
}
