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
                            Gradient.Stop(color: Color(red: 191/255, green: 18/255, blue: 48/255), location: 0.5),
                            Gradient.Stop(color: Color(red: 158/255, green: 15/255, blue: 39/255), location: 0.5)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .cornerRadius(10)
                .padding()
            VStack {
                HStack {
                    GeometryReader { geometry in
                        Image("UofGLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width)
                    }
                    Spacer()
                }
                Spacer()
            }.padding(.leading, 30)
            VStack(alignment: .trailing) {
                Spacer()
                Text("$" + String(format: "%.2f", customer.mealPlan?.currentBalance ?? 0))
                    .font(.largeTitle).bold()
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.white)
                    .padding(.trailing, 30)
                Text(customer.name + studentNumber)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .padding([.trailing, .bottom], 30)
            }
        }.frame(maxWidth: 400, maxHeight: 250)
            .aspectRatio(400/250, contentMode: .fit) //TODO: This is probably hacky
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
