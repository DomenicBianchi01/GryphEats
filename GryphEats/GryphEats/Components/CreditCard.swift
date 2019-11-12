//
//  CreditCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-16.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CreditCard

struct CreditCard: View {
    
    // MARK: Lifeycle
    
    init(cardProvider: CardProvider, lastFourDigits: String) {
        self.cardProvider = cardProvider
        self.lastFourDigits = lastFourDigits
    }
    
    // MARK: - Internal
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(
                        stops: [
                            Gradient.Stop(color: self.gradientStartColor, location: 0.5),
                            Gradient.Stop(color: self.gradientEndColor, location: 0.5)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .cornerRadius(10)
                .padding()
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text("•••• \(lastFourDigits)")
                        .foregroundColor(.white)
                    Spacer()
                }
            }.padding([.leading, .bottom], 30)
            VStack(alignment: .trailing) {
                Spacer()
                self.logoView
                
            }
        }.frame(maxWidth: 400)
            .frame(idealHeight: 260)
            .aspectRatio(400/260, contentMode: .fit)
    }
    
    // MARK: Private
    
    private let cardProvider: CardProvider
    private let lastFourDigits: String
    
    private var gradientStartColor: Color {
        switch cardProvider {
        case .visa:
            return Color(red: 26/255, green: 31/255, blue: 113/255)
        case .mastercard:
            return Color(red: 235/255, green: 0/255, blue: 27/255)
        }
    }
    
    private var gradientEndColor: Color {
        switch cardProvider {
        case .visa:
            return Color(red: 247/255, green: 182/255, blue: 0/255)
        case .mastercard:
            return Color(red: 255/255, green: 95/255, blue: 0/255)
        }
    }
    
    private var logoView: some View {
        switch cardProvider {
        case .visa:
            return Image("visaLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .padding([.trailing], 30)
        case .mastercard:
            return Image("mastercardLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90)
                .padding([.trailing, .bottom], 20)
        }
    }
}

struct CreditCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CreditCard(cardProvider: .visa, lastFourDigits: "1234")
            CreditCard(cardProvider: .mastercard, lastFourDigits: "1234")
        }
    }
}
