//
//  View+NavigationBar.swift
//  InternetShop
//
//  Created by kair on 24.10.26.
//

import SwiftUI

extension View {
    /// Solid white navigation bar shared by all screens (no gray material on scroll).
    func appNavigationBar() -> some View {
        toolbarBackground(Color.appWhite, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
