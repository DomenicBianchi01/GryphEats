//
//  RestOrdersView.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/10/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct RestOrdersView: View {
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        //        UINavigationBar.appearance().largeTitleTextAttributes = [.back: UIColor.red]
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 42)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 30)!]
        
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        //        UINavigationBar.appearance().backgroundColor = Color.guelphYellow
    }
    
    var body: some View {
        NavigationView {
            List (0..<5) { item in
                NavigationLink(destination: SecondView()) {
                    OrderRow()
                }
            }.navigationBarTitle("Orders")
            Text("Select an order from the list to get started")
        }
    }
}

struct RestOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        RestOrdersView()
    }
}

struct SecondView: View {
    var body: some View {
        OrderDetailsView().navigationBarTitle("Order Details", displayMode: .large)
        //        Text("Select an order from the list to get started")
    }
}
