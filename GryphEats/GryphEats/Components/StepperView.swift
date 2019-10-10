//
//  StepperView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-09.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - StepperValue

class StepperValue: ObservableObject {
    
    // MARK: Lifecycle
    
    init(step: Int = 0) {
        self.step = step
    }
    
    // MARK: Internal
    
    @Published var step: Int
    
}

// MARK: - StepperView

struct StepperView: View {
    
    // MARK: Lifecycle
    
    init(text: String, stepperValue: StepperValue, add: @escaping () -> Void, subtract: @escaping () -> Void) {
        self.text = text
        self.stepperValue = stepperValue
        self.add = add
        self.subtract = subtract
    }
    
    // MARK: Internal
    
    var body: some View {
        HStack {
            Text(text).bold()
            
            Spacer()
            
            Button(action: {
                self.subtract()
            }) {
                image(named: "minus")
            }
            
            Text("\(stepperValue.step)")
                .bold()
                .padding(.horizontal)
            
            Button(action: {
                self.add()
            }) {
                image(named: "plus")
            }
        }.padding()
    }
    
    // MARK: Private
    
    @ObservedObject private var stepperValue: StepperValue
    
    private let text: String
    private let add: () -> Void
    private let subtract: () -> Void
    
    private func image(named: String) -> some View {
        return Image(systemName: named)
            .frame(width: 44, height: 44)
            .background(Color.gray)
            .foregroundColor(.black)
            .cornerRadius(5)
    }
    
}

struct StepperView_Previews: PreviewProvider {
    
    static var stepperValue = StepperValue()
    
    static var previews: some View {
        StepperView(
            text: "Some text",
            stepperValue: stepperValue,
            add: { stepperValue.step += 1 },
            subtract: { stepperValue.step -= 1 })
    }
}
