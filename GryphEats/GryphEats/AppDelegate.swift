//
//  AppDelegate.swift
//  UofG-Hospitality-Order-Now
//
//  Created by Domenic Bianchi on 2019-09-19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: Push Notifications
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // https://www.raywenderlich.com/8164-push-notifications-tutorial-getting-started
        let token = deviceToken.map { data in String(format: "%02.2hhx", data) }.joined()
        
        print(token)
        
        guard let uuid = UIDevice.current.identifierForVendor?.uuidString, let userID = loggedInUserID else {
            return
        }
        
        GraphClient.shared.perform(mutation: RegisterForPushNotificationsMutation(
            userID: userID,
            uuid: uuid,
            token: token))
        { result in
            switch result {
            case .success(let data):
                print(data.didRegister ?? false)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        //TODO
    }
}

// SUPER HACK
var loggedInUserID: String? = nil
