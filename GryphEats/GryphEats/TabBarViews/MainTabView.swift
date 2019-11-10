//
//  MainTabView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-23.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - MainTabView

struct MainTabView: View {
    
    // MARK: Internal
    
    var body: some View {
        VStack(spacing: -1) {
            if selection == 0 {
                homeView
            } else if selection == 1 {
                ordersView
            } else {
                accountView
            }
            
            CustomTabBar(selectedIndex: $selection, items: [
                CustomTabBarItem(icon: .system(name: "house"), title: "Menus"),
                CustomTabBarItem(icon: .system(name: "dollarsign.square"), title: "Orders"),
                CustomTabBarItem(icon: .system(name: "person"), title: "Account")
            ])
        }.edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: Private
    
    @State private var selection: Int = 0
    
    private let homeView = AnyView(HomeView().environmentObject(Cart()))
    private let ordersView = OrdersView()
    private let accountView = AccountView()
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
