//
//  MenuCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-07.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - MenuCard

struct MenuCard: View {
    
    // MARK: Lifecycle
    
    init(itemName: String, imageUrl: String, onTap: @escaping () -> Void) {
        self.itemName = itemName
        self.onTap = onTap
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        imageLoader.fetchImage(from: url)
    }
    
    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .leading) {
            Group {
                if imageLoader.image == nil {
                    ActivityIndicatorView(color: .white)
                } else {
                    Image(uiImage: imageLoader.image!).resizable()
                }
            }.aspectRatio(contentMode: .fill)
                .frame(width: frameSize.width, height: frameSize.height)
            VStack {
                Text(itemName)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }.padding([.top, .leading], 10)
        }.frame(width: frameSize.width, height: frameSize.height)
            .background(Color(red: 75/255, green: 75/255, blue: 75/255))
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .onTapGesture {
                self.onTap()
        }
    }
    
    // MARK: Private
    
    @ObservedObject private var imageLoader = ImageClient()
    
    private let onTap: () -> Void
    private let itemName: String
    private let frameSize = CGSize(width: 150, height: 200)
    
}

struct MenuCard_Previews: PreviewProvider {
    static var previews: some View {
        MenuCard(itemName: "Hamburger", imageUrl: "hamburger", onTap: { print("Tapped") })
    }
}
