//
//  RestOrdersView.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/10/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct RestOrdersView: View {
    
    var orders: [Order] = []
    @State var isSelected = false
    
    @ObservedObject private var viewModel: RestOrdersViewModel
    
    init(restID: String) {
        viewModel = RestOrdersViewModel(restID: restID)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 42)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 30)!]
    }
    
    var body: some View {
        Group {
            self.content.navigationBarItems(trailing: CircularButton(text: Text("Refresh"), backgroundColor: .guelphYellow, foregroundColor: .white) {
                self.viewModel.fetchOrders()
            }.padding(.top)).layoutPriority(-1)
        }.onAppear() {
            self.viewModel.fetchOrders()
            UITableView.appearance().separatorColor = .clear
        }.onDisappear() {
            UITableView.appearance().separatorColor = .separator
            self.viewModel.cancelSubscription()
        }
    }
    
    private var content: AnyView {
        switch viewModel.loadingState {
        case .loading:
            return AnyView(VStack {
                Spacer()
                ActivityIndicator(style: .large)
                Spacer()
            })
        case .loaded(let orders):
            if ( UIDevice.current.userInterfaceIdiom == .pad ) {
                return AnyView(
                    NavigationView {
                        List {
                            ForEach(orders) { order in
                                NavigationLink(destination: OrderDetailsView(order: order).navigationBarTitle("Order Details")) {
                                    OrderCard(order: order, enableShadow: false, isCollapsable: false, fillSpace: true)
                                }
                            }
                        }
                        if ( UIDevice.current.userInterfaceIdiom == .pad ) {
                            Text("Select an order from the list to get started")
                        }
                    }
                )
            } else {
                return AnyView(List {
                    ForEach(orders) { order in
                        NavigationLink(destination: OrderDetailsView(order: order).navigationBarTitle("Order Details")) {
                            OrderCard(order: order, enableShadow: false, isCollapsable: false, fillSpace: true)
                        }
                    }
                })
            }
        case .error:
            return AnyView(ErrorView(infoText: "Whoops! We could not fetch the stations.", buttonText: "Try Again") {
                self.viewModel.fetchOrders()
            })
        }
    }
}
