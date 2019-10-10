//
//  OrderReviewView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderReviewView

struct OrderReviewView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
    }
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart

}

struct OrderReviewView_Previews: PreviewProvider {
    static var previews: some View {
        OrderReviewView().environmentObject(Cart())
    }
}
