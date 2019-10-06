//
//  ViewExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

extension View {
    
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
}
