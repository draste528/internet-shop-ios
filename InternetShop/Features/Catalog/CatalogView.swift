//
//  CatalogView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct CatalogView: View {
    @ObservedObject var viewModel: CatalogViewModel
    @StateObject private var router = Router<CatalogRoute>()
    @FocusState private var searchFocused: Bool

    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(spacing: 0) {
                SearchBar(text: $viewModel.searchText, isFocused: $searchFocused)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                content
            }
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: CatalogRoute.self) { route in
                switch route {
                case .categoryDetail(let category):
                    CategoryDetailView(viewModel: CategoryDetailViewModel(category: category))
                }
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if viewModel.filteredCategories.isEmpty {
            emptyState
        } else {
            grid
        }
    }

    private var grid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(viewModel.filteredCategories) { category in
                    Button {
                        searchFocused = false          // close keyboard before navigating
                        router.push(.categoryDetail(category))
                    } label: {
                        CategoryCardView(viewModel: CategoryCardViewModel(category: category))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(16)
        }
        .scrollDismissesKeyboard(.immediately)
    }

    @ViewBuilder
    private var emptyState: some View {
        if viewModel.searchText.isEmpty {
            ContentUnavailableView("No categories", systemImage: "square.grid.2x2")
        } else {
            ContentUnavailableView.search(text: viewModel.searchText)
        }
    }
}
