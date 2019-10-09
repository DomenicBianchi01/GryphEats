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
    
    init(itemName: String, imageName: String, onTap: @escaping () -> Void) {
        self.itemName = itemName
        self.imageName = imageName
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frameSize.width, height: frameSize.height)
            VStack {
                Text(itemName)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }.padding([.top, .leading], 10)
        }.frame(width: frameSize.width, height: frameSize.height)
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .onTapGesture {
                self.onTap()
        }
    }
    
    // MARK: Private
    
    private let onTap: () -> Void
    
    private let itemName: String
    private let imageName: String //TODO: Will need to change this to a Data type probably
    
    private let frameSize = CGSize(width: 150, height: 200)
    
}

struct MenuCard_Previews: PreviewProvider {
    static var previews: some View {
        MenuCard(itemName: "Hamburger", imageName: "hamburger", onTap: { print("Tapped") })
    }
}
