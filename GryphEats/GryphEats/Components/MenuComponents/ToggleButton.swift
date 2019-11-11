//
//  ToggleButton.swift
//  GryphEats
//
//  Created by Owner on 11/9/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct ToggleButton: View {
    
    init(text1: String, text2: String, onTap: @escaping () -> Void) {
        self.button1Text = text1
        self.button2Text = text2
        self.onTap = onTap
    }
    
    var body: some View {
        HStack() {
            Button (action: {
                self.onTap()
                self.toggleButton1()
            }){
                HStack {
                    Spacer()
                    Text(button1Text)
                        .foregroundColor(Color.black)
                        .font(.system(size: 24, weight: .semibold))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }.padding(.vertical, 15)
                .contentShape(Rectangle())
                .background(isSelected ? Color.guelphYellow : Color.white)
            
            Button (action: {
                self.onTap()
                self.toggleButton2()
            }){
                HStack {
                    Spacer()
                    Text(button2Text)
                        .foregroundColor(Color.black)
                        .font(.system(size: 24, weight: .semibold))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }.padding(.vertical, 15).contentShape(Rectangle())
                .background(isSelected ? Color.white : Color.guelphYellow)
        }.contentShape(Rectangle())
            .cornerRadius(5)
            .shadow(radius: 2)
            .padding(.horizontal)
    }
    
    @State var isSelected: Bool = false
    
    private let onTap: () -> Void
    private let button1Text: String
    private let button2Text: String
    
    private func toggleButton1() {
        if (!isSelected) {
            isSelected.toggle()
        }
    }
    
    private func toggleButton2() {
        if (isSelected) {
            isSelected.toggle()
        }
    }
}
