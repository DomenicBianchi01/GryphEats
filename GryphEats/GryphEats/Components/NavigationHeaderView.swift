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
            GeometryReader { proxy in
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(self.contentBackgroundColor)
                        .edgesIgnoringSafeArea(.bottom)
                    self.content()
                    Rectangle()
                        .fill(self.navigationColor)
                        .frame(height: self.frameHeight(using: proxy.size.height))
                        .edgesIgnoringSafeArea(.top)
                }
            }.navigationBarTitle(self.title)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: Private
    
    private let content: () -> V
    
    private let title: String
    private let navigationColor: Color
    private let contentBackgroundColor: Color
    
    // This entire function is just a terrible hack...
    private func frameHeight(using proxyHeight: CGFloat) -> CGFloat {
        if let statusBarHeight = UIApplication.shared.firstKeyWindow?.windowScene?.statusBarManager?.statusBarFrame.size.height,
            UIDevice.current.hasBottomSafeArea
        {
            return UIScreen.main.bounds.height - proxyHeight - statusBarHeight + (UIDevice.current.isPad ? 4 : 10)
        }
        
        return UIScreen.main.bounds.height - proxyHeight
    }
}

struct NavigationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeaderView(
            title: "Test Title",
            navigationColor: .green,
            contentBackgroundColor: .red)
        {
            ScrollView {
                Text("Test")
                Text("Test")
                Text("Test")
                Text("Test")
                Text("Test")
                Text("Test")
            }
        }
    }
}
