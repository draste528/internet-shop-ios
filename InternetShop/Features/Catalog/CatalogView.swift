//
//  CatalogView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct CatalogView: View {
    @ObservedObject var viewModel: CatalogViewModel
    @ObservedObject private var router: Router<CatalogRoute>

    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
        _router = ObservedObject(wrappedValue: viewModel.router)
    }

    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationTitle(viewModel.title)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search"
                )
                .navigationDestination(for: CatalogRoute.self) { route in
                    switch route {
                    case .itemsList(let category):
                        ItemsListView(viewModel: ItemsListViewModel(category: category), router: router)
                        case .itemDetail(let itemId):
                            ItemDetailView(itemId: itemId)
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
                        viewModel.showDetail(for: category)
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
