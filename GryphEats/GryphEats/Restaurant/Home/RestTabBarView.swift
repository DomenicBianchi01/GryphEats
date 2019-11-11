//
//  RestTabBarView.swift
//  GryphEats
//
//  Created by Owner on 11/10/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - RestTabBarView

struct RestTabBarView: View {
    
    // MARK: Internal
    
    var body: some View {
        VStack(spacing: -1) {
            if selection == 0 {
                homeView
            } else if selection == 1 {
                editView
            } else {
                accountView
            }
            
            CustomTabBar(selectedIndex: $selection, items: [
                CustomTabBarItem(icon: .system(name: "house"), title: "Stations"),
                CustomTabBarItem(icon: .system(name: "dollarsign.square"), title: "Edit Menu"),
                CustomTabBarItem(icon: .system(name: "person"), title: "Account"),
            ])
        }.edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: Private
    
    @State private var selection: Int = 0
    
    private let homeView = RestStationsView()
    private let editView = RestEditStationsView()
    private let accountView = AccountView()
    
}
