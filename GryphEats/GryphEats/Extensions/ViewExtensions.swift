//
//  ViewExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - View

extension View {
    
    // MARK: Internal
    
    /// Display a simple alert. The `title` of the alert will be the description of the error. The `message` of the alert will be the recovery suggestion of the error.
    func errorAlert<E: LocalizedError>(error: E?, completion: @escaping () -> Void) -> some View {
        self.alert(isPresented: .constant(error != nil)) {
            Alert(
                title: Text(error?.errorDescription ?? ""),
                message: Text(error?.recoverySuggestion ?? ""),
                dismissButton: .default(Text("OK")) {
                    completion()
                })
        }
    }
    
    /// Adds a double tap guesture that will dismiss the keyboard
    func dismissKeyboardOnTapGesture() -> some View {
        //Swift UI Bug: If used with `Picker` and the tap guesture count is set to 1, the picker will become unresponsive
        // The workaround to this is to make the "tap to dismiss keyboard" ffunctionality require a double tap.
        self.onTapGesture(count: 2) {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func listConfiguration(backgroundColor: Color, removeInsets: Bool = false) -> AnyView {
        let updatedView = self.listRowBackground(backgroundColor)
        
        if removeInsets {
            return AnyView(updatedView.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)))
        }
        
        return AnyView(updatedView)
    }
}

// MARK: - Dismissable

protocol Dismissable {
    
    // MARK: Internal
    
    var presentationMode: Binding<PresentationMode> { get }
    
}

extension View where Self: Dismissable {
    
    // MARK: Internal
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
