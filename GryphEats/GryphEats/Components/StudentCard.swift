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
    
    init(customer: Customer) {
        self.customer = customer
    }
    
    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(
                        stops: [
                            Gradient.Stop(color: .guelphRed, location: 0.5),
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
                    Text("$" + String(format: "%.2f", customer.mealPlan?.currentBalance ?? 0))
                        .font(.largeTitle).bold()
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 30)
                    Text(customer.name + studentNumber)
                        .multilineTextAlignment(.trailing)
                        .padding([.trailing, .bottom], 30)
                }.foregroundColor(.white)
            }
        }.frame(maxWidth: 400, maxHeight: 250)
            .aspectRatio(contentMode: .fit)
    }
    
    // MARK: Private
    
    private let customer: Customer
    
    private var studentNumber: String {
        guard let studentNumber = customer.mealPlan?.accountNumber else {
            return ""
        }
        
        return "\n\(studentNumber)"
    }
}

struct StudentCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StudentCard(customer: Customer(name: "Domenic Bianchi", mealPlan: MealPlan(currentBalance: 5000, accountNumber: "0921557")))
            StudentCard(customer: Customer(name: "Domenic Bianchi"))
        }
    }
}
