//
//  SettingsView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct SettingsView: View {

    // MARK: - Properties
    @StateObject private var viewModel = SettingsViewModel()

    // MARK: - Body
    var body: some View {
        Text(viewModel.title)
    }
}

#Preview {
    SettingsView()
}
