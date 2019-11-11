//
//  AccountView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-27.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - AccountView

struct AccountView: View {
    
    // MARK: Internal
    
    var body: some View {
        NavigationHeaderView(
            title: "Account",
            navigationColor: .navigationGuelphYellow(for: colorScheme),
            contentBackgroundColor: .lightGray(for: colorScheme))
        {
            List(self.viewModel.rows) { row in
                Button(action: {
                    self.buttonTapped(at: row.id)
                }) {
                    Text(row.text)
                        .foregroundColor(row.foregroundColor)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: row.alignment)
                }
            }.listStyle(GroupedListStyle())
        }.onAppear {
            UITableView.appearance().separatorStyle = .singleLine
            UITableView.appearance().backgroundColor = .lightGray
        }
    }
    
    // MARK: Private
    
    @Environment(\.viewController) private var viewControllerHolder
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    private let viewModel = AccountViewModel()
    
    private func buttonTapped(at id: AccountViewModel.Row.ID) {
        if id == .logout {
            viewModel.clearKeychain()
            viewControllerHolder.value?.dismiss(animated: true)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
