//
//  RestEditMenuModel.swift
//  GryphEats
//
//  Created by Owner on 11/9/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

class RestEditMenuViewModel: ObservableObject {
    // MARK: Internal
    
    @Published var loadingState: LoadingState<[Restaurant]> = .loading
    private var restID: String
    
    init(restID: String) {
        self.restID = restID
    }
    
    // MARK: Private
    
    func fetchMenus() {
        self.loadingState = .loading
        
        GraphClient.shared.fetch(query: MenusByRestQuery(restID: restID)) { result in
            switch result {
            case .success(let data):
                
                self.loadingState = .loading

//                self.loadingState = .loaded()
            case .failure:
                self.loadingState = .error
            }
        }
    }
}
