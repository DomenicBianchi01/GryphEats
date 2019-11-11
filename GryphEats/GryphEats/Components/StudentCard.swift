//
//  StudentCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-03.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - StudentCard

struct StudentCard: View {
    
    // MARK: Lifecycle
    
    init(name: String, studentNumber: String, balance: Double) {
        self.name = name
        self.studentNumber = studentNumber
        self.balance = balance
    }
    
    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(
                        stops: [
                            Gradient.Stop(color: .guelphRed(for: .light), location: 0.5),
                            Gradient.Stop(color: Color(red: 158/255, green: 15/255, blue: 39/255), location: 0.5)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .cornerRadius(10)
                .padding()
            VStack {
                GeometryReader { proxy in
                    HStack {
                        Image("UofGLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: proxy.size.width / 2)
                    }
                    Spacer()
                }
            }.padding([.leading, .top], 30)
            VStack(alignment: .trailing) {
                Spacer()
                Group {
                    Text("$" + String(format: "%.2f", balance))
                        .font(.largeTitle).bold()
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 30)
                    Text(name + "\n" + studentNumber)
                        .multilineTextAlignment(.trailing)
                        .padding([.trailing, .bottom], 30)
                }.foregroundColor(.white)
            }
        }.frame(maxWidth: 400)
            .frame(idealHeight: 260)
            .aspectRatio(400/260, contentMode: .fit)
    }
    
    // MARK: Private
    
    private let name: String
    private let studentNumber: String
    private let balance: Double
    
}

struct StudentCard_Previews: PreviewProvider {
    static var previews: some View {
        StudentCard(name: "Domenic Bianchi", studentNumber: "0921557", balance: 5000)
    }
}
