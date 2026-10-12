//
//  ItemsListView.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//

import SwiftUI

struct ItemsListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ItemsListViewModel

    @MainActor
    init(category: Category, router: Router<CatalogRoute>) {
        _viewModel = StateObject(wrappedValue: ItemsListViewModel(category: category, router: router))
    }

    var body: some View {
            VStack(spacing: 0) {
                SortFilterBar()
                content
            }
            .background(Color.appWhite)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .screenSearchable(text: $viewModel.searchText, prompt: "Search items")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton { dismiss() }
                }
            }
            .task { await viewModel.loadItems() }
        }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if viewModel.filteredItems.isEmpty {
            emptyState
        } else {
            list
        }
    }
    
    private var list: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredItems) { item in
                    Button {
                        viewModel.showItemDetails(itemId: item.id)
                    } label: {
                        ItemRow(item: item)
                    }
                    .buttonStyle(.plain)

                    Rectangle()
                        .fill(Color.appLightGray)
                        .frame(height: 1)
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
    }
    
    @ViewBuilder
    private var emptyState: some View {
        if viewModel.searchText.isEmpty {
            ContentUnavailableView("No items", systemImage: "tray")
        } else {
            ContentUnavailableView.search(text: viewModel.searchText)
        }
    }
}
