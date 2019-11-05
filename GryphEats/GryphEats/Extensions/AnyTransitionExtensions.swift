//
//  AnyTransitionExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - AnyTransition

extension AnyTransition {
    
    // MARK: Internal
    
    static var leftSlide: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .trailing))
    }
    
    static var rightSlide: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))
    }
}
