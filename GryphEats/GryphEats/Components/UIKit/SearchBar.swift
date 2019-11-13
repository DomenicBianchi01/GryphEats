//
//  SearchBar.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-12.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - SearchBar

/// `UISearchBar` bridged over to SwiftUI
final class SearchBar: NSObject, UIViewRepresentable {
    
    // MARK: Lifecycle
    
    init(placeholder: String, textDidChange: @escaping (String) -> Void) {
        self.placeholder = placeholder
        self.textDidChange = textDidChange
    }

    // MARK: Internal
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = placeholder
        searchBar.delegate = self
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.delegate = self
    }
    
    // MARK: Private
    
    private let placeholder: String
    private let textDidChange: (String) -> Void
    
}

// MARK: UISearchBarDelegate

extension SearchBar: UISearchBarDelegate {
    
    // MARK: Internal
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textDidChange(searchText)
    }
}
