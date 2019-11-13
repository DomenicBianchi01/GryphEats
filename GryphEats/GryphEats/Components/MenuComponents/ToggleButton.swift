//
//  ToggleButton.swift
//  GryphEats
//
//  Created by Owner on 11/9/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct ToggleButton: View {
    
    enum Selected {
        case left
        case right
        
        // MARK: Fileprivate
        
        fileprivate mutating func toggleLeft() {
            self = .left
        }
        
        fileprivate mutating func toggleRight() {
            self = .right
        }
    }
    
    init(selectedState: Selected, text1: String, text2: String, onTap: @escaping () -> Void) {
        _selected = State(initialValue: selectedState)
        self.button1Text = text1
        self.button2Text = text2
        self.onTap = onTap
    }
    
    var body: some View {
        HStack() {
            Button (action: {
                self.onTap()
                self.selected.toggleLeft()
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
                .background(selected == Selected.left ? Color.guelphYellow : Color.white)
            Button (action: {
                self.onTap()
                self.selected.toggleRight()
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
                .background(selected == Selected.left ? Color.white : Color.guelphYellow)
        }.contentShape(Rectangle())
            .cornerRadius(5)
            .shadow(radius: 2)
            .padding(.horizontal)
    }
    
    @State private var selected: Selected
    private let onTap: () -> Void
    private let button1Text: String
    private let button2Text: String
    
//    private func toggleButton1() {
//        if (!isSelected) {
//            isSelected.toggle()
//        }
//    }
//
//    private func toggleButton2() {
//        if (isSelected) {
//            isSelected.toggle()
//        }
//    }
}
