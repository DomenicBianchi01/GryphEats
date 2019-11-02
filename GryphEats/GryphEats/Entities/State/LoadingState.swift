//
//  LoadingState.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-01.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - LoadingState

enum LoadingState<T> {
    case loading
    case loaded(T)
    case error
}
