//
//  View+Search.swift
//  InternetShop
//
//  Created by kair on 12.10.26.
//

import SwiftUI

extension View {
    /// Shared search field used by all list screens.
    func screenSearchable(text: Binding<String>, prompt: String = "Search") -> some View {
        searchable(
            text: text,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: prompt
        )
    }
}
