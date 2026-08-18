//
//  SettingsView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    var body: some View {
        NavigationStack {
            VStack { }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.appWhite)
                .navigationTitle(viewModel.title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
