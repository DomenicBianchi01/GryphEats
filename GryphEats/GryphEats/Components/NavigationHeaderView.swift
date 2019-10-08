//
//  NavigationHeaderView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: NavigationHeaderView

struct NavigationHeaderView<V: View>: View {
    
    // MARK: Lifecycle
    
    init(
        title: String,
        navigationColor: Color,
        contentBackgroundColor: Color,
        content: @escaping () -> V)
    {
        self.title = title
        self.navigationColor = navigationColor
        self.contentBackgroundColor = contentBackgroundColor
        self.content = content
    }
    
    // MARK: Internal
    
    var body: some View {
        NavigationView {
            // There doesn't seem to be a way to change the status bar color or tell the NavigationView to extend its
            // color into the status bar. As a result, the code below is a hack make the color of the navigation bar the
            // same as the status bar
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(navigationColor)
                    .edgesIgnoringSafeArea(.top)
                Rectangle()
                    .fill(contentBackgroundColor)
                content()
            }.navigationBarTitle(title)
        }
    }
    
    // MARK: Private
    
    private let content: () -> V
    
    private let title: String
    private let navigationColor: Color
    private let contentBackgroundColor: Color
}

struct NavigationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeaderView(
            title: "Test Title",
            navigationColor: .green,
            contentBackgroundColor: .red) {
                Text("Test")
        }
    }
}
