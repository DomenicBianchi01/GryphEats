//
//  HomeView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - HomeView

struct HomeView: View {
    
    // MARK: Lifecycle
    
    init() {
        UINavigationBar.appearance().backgroundColor = .guelphYellow
    }
    
    // MARK: Internal
    
    var body: some View {
        NavigationHeaderView(
            title: "GryphEats",
            navigationColor: .guelphYellow,
            contentBackgroundColor: .lightGray)
        {
            VStack(alignment: .leading, spacing: 0) {
                SliderView(type: .categories(self.viewModel.categories)) { index in
                    print("Tapped category card \(index)")
                }.background(Color.white)
                
                Divider()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(self.viewModel.resutrants) { resturant in
                            ResturantItemsView(resturant: resturant)
                        }
                    }
                }.background(Color.lightGray)
            }
        }
    }
    
    // MARK: Private
    
    private let viewModel = HomeViewModel()
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
