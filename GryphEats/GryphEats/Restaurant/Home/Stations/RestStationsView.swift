//
//  RestStationsView.swift
//  GryphEats
//
//  Created by Owner on 11/8/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import QGrid

struct RestStationsView: View {
    
    @Environment(\.viewController) private var viewControllerHolder
    
    var body: some View {
        NavigationHeaderView(title: "Stations", navigationColor: .guelphYellow, contentBackgroundColor: .white) {
            self.content
        }.onAppear {
            self.viewModel.fetchRestaurants()
        }
    }
    
    @ObservedObject private var viewModel = RestStationsViewModel()
    
    private var content: AnyView {
        switch viewModel.loadingState {
        case .loading:
            return AnyView(ActivityIndicatorView())
        case .loaded(let restaurants):
            if ( UIDevice.current.userInterfaceIdiom == .phone ) {
                return AnyView( QGrid(restaurants,
                                      columns: 2,
                                      columnsInLandscape: 2,
                                      vSpacing: 50,
                                      hSpacing: 5,
                                      vPadding: 1,
                                      hPadding: 20) {
                                        restaurant in RestCell(restaurant: restaurant) {
                                            RestOrdersView(restID: restaurant.id)
                                        }
                })
            } else {
                return AnyView(QGrid(restaurants,
                                     columns: 3,
                                     columnsInLandscape: 3,
                                     vSpacing: 50,
                                     hSpacing: 5,
                                     vPadding: 1,
                                     hPadding: 20) {
                                        restaurant in RestCell(restaurant: restaurant) {
                                            RestOrdersView(restID: restaurant.id)
                                        }
                })
            }
        case .error:
            return AnyView(ErrorView(infoText: "Whoops! We could not fetch the stations.", buttonText: "Try Again") {
                self.viewModel.fetchRestaurants()
            })
        }
    }
}

struct RestStationsView_Previews: PreviewProvider {
    static var previews: some View {
        RestStationsView()
    }
}

