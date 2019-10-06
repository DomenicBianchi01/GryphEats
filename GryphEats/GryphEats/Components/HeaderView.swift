//
//  HeaderView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - HeaderView

struct HeaderView: View {
    
    // MARK: Lifecycle
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .bold()
            Text(subtitle)
                .padding(.bottom, 30)
        }.padding(.leading, 30)
    }
    
    // MARK: Private
    
    private let title: String
    private let subtitle: String
    
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", subtitle: "Subtitle")
    }
}
