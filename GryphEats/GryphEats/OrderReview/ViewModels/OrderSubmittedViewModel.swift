//
//  OrderSubmittedViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-06.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import UIKit
import UserNotifications

// MARK: - OrderSubmittedViewModel

class OrderSubmittedViewModel {
    
    // MARK: Internal
    
    func registerForNotifications(for user: User) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    loggedInUserID = user.id
                }
            }
        }
    }
}
