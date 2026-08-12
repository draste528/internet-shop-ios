//
//  CatalogView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct CatalogView: View {
    @StateObject private var viewModel = CatalogViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(viewModel.categories) { category in
                    CategoryCardView(viewModel: CategoryCardViewModel(category: category))
                }
            }
            .padding(16)
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .task {
            await viewModel.loadCategories()
        }
    }
}
