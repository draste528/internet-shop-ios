//
//  FavoritesView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct FavoritesView: View {

    // MARK: - Properties
    @StateObject private var viewModel = FavoritesViewModel()

    // MARK: - Body
    var body: some View {
        Text(viewModel.title)
    }
}

#Preview {
    FavoritesView()
}
