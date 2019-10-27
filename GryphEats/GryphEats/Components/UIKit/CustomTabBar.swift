//
//  CustomTabBar.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-23.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CustomTabBar

/// The `TabView` in SwiftUI is so limited in what it can do (let alone is very buggy) that it is just easier to make a custom tab bar....
struct CustomTabBar: View {
    
    // MARK: Lifecycle
    
    init(selectedIndex: Binding<Int>, items: [CustomTabBarItem]) {
        self._selectedIndex = selectedIndex
        self.items = items
    }
    
    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle().fill(Color.gray).frame(height: 0.75)
            HStack {
                ForEach(items.indices) { index in
                    Spacer()
                    HStack(alignment: .center) {
                        Button(action: {
                            self.selectedIndex = index
                        }) {
                            CustomTabBarItemView(isSelected: index == self.selectedIndex, item: self.items[index])
                        }
                    }
                    Spacer()
                }
            }.padding(.horizontal)
        }.frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.white)
            .padding(.top, 0.75)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    // MARK: Private
    
    @Binding private var selectedIndex: Int
    
    private let items: [CustomTabBarItem]
    
}

// MARK: - CustomTabBarItem

struct CustomTabBarItem {
    
    // MARK: Icon
    
    enum Icon {
        case system(name: String)
        case custom(name: String)
    }
    
    // MARK: Internal
    
    let icon: Icon
    let title: String
    
}

// MARK: - CustomTabBarItemView

private struct CustomTabBarItemView: View {
    
    // MARK: Lifecycle
    
    init(isSelected: Bool, item: CustomTabBarItem) {
        self.isSelected = isSelected
        self.item = item
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            image
            
            Text(item.title)
                .font(.system(size: 10))
                .lineLimit(1)
        }.padding().padding(.bottom, 10)
            .foregroundColor(isSelected ? .guelphRed : .gray)
            .frame(maxWidth: .infinity)
    }
    
    // MARK: Private
    
    private let isSelected: Bool
    private let item: CustomTabBarItem
    
    private var image: AnyView {
        switch item.icon {
        case .system(let name):
            return AnyView(Image(systemName: isSelected ? name + ".fill" : name)
                .imageScale(.large))
        case .custom(let name):
            return AnyView(Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 20))
        }
    }
}

// MARK: - CustomTabBar_Previews

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBar(
                selectedIndex: .constant(0),
                items: [
                    CustomTabBarItem(icon: .system(name: "house"), title: "Option 1"),
                    CustomTabBarItem(icon: .system(name: "dollarsign.square"), title: "Option 2"),
                    CustomTabBarItem(icon: .system(name: "person"), title: "Option 3")
            ])
        }.background(Color.blue)
            .edgesIgnoringSafeArea(.bottom)
    }
}
