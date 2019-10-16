//
//  OrderDetailsView.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/10/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import QGrid

struct OrderDetailsView: View {
    @State var clickedCount: Int = 0
    @State var isExitDisabled: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(){
                Spacer()
            }.padding(.leading)
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Domenic Bianchi").font(Font.custom("Roboto-Bold", size: 28))
                        .lineLimit(1)
                    Text("Order placed 2 minutes ago (11:28am)").font(Font.custom("Roboto-Regular", size: 24))
                        .lineLimit(1)
                }
                Spacer().layoutPriority(-1)
                HStack() {
                    CircularButton(
                        text: Text(continueButtonText).font(Font.custom("Roboto-Light", size: 22)),
                        backgroundColor: continueButtonColor,
                        foregroundColor: .black) {
                            self.continueOrder()
                    }.padding(.trailing)
                    CircularButton(
                        text: Text(exitButtonText).font(Font.custom("Roboto-Light", size: 22)),
                        backgroundColor: exitButtonColor,
                        foregroundColor: .black) {
                            self.backOrder()
                    }.padding(.trailing).disabled(isExitDisabled)
                }
            }
            Divider()
            List (0..<5) { item in
                MealRow()
            }
        }.padding(.all)
    }
    
    var continueButtonColor: Color {
        let colors: [Color] = [.blue, .guelphYellow, .green, .gray]
        return colors[clickedCount]
    }
    
    var continueButtonText: String {
        let text = ["Begin Order", "Complete Order", "Recieved Order"]
        return text[clickedCount]
    }
    
    var exitButtonColor: Color {
        let colors: [Color] = [.red, .red, .gray]
        return colors[clickedCount]
    }
    
    var exitButtonText: String {
        let text = ["Decline Order", "Cancel Order", "Order Complete"]
        return text[clickedCount]
    }
    
    private func continueOrder() {
        clickedCount = clickedCount+1
        isExitDisabled = false
        if (clickedCount >= 3) {
            isExitDisabled = true
            clickedCount = 0
        }
    }
    
    private func backOrder() {
        clickedCount = clickedCount-1
        if (clickedCount <= 0) {
            clickedCount = 2
        }
    }
}

struct OrderDetailsView_preview: PreviewProvider {
    static var previews: some View {
        OrderDetailsView()
    }
}
