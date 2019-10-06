//
//  CustomUIHostingController.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CustomUIHostingController

final class CustomUIHostingController<V: View>: UIHostingController<V> {
    
    override init(rootView: V) {
        super.init(rootView: rootView)
        
        view.backgroundColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
