//
//  UIViewControllerExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import UIKit
import SwiftUI

//https://stackoverflow.com/a/56880640

extension UIViewController {
    
    /// SwiftUI currently does not support modally presenting a view as `.fullScreen`. As a result, we need hack around this limitation and use UIKit.
    func present<Content: View>(
        style: UIModalPresentationStyle = .automatic,
        @ViewBuilder builder: () -> Content)
    {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        
        toPresent.modalPresentationStyle = style
        toPresent.rootView = AnyView(
            builder().environment(\.viewController, ViewControllerHolder(value: toPresent))
        )

        self.present(toPresent, animated: true, completion: nil)
    }
}
