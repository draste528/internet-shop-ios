//
//  ItemsListView.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//


import SwiftUI

struct ItemsListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: ItemsListViewModel
    @ObservedObject var router: Router<CatalogRoute>
    
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            SearchBar(text: $viewModel.searchText, isFocused: $isSearchFocused, placeholder: "Search items")
                .padding(.vertical, 8)
            
            SortFilterBar(onSort: {}, onFilter: {})
            
            content
        }
        .background(Color.appWhite)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
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
            LazyVStack(spacing: 16) {
                ForEach(viewModel.filteredItems) { item in
                    Button {
                        isSearchFocused = false
                        router.push(.itemDetail(item.id))
                    } label: {
                        ItemRow(item: item)
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
            ContentUnavailableView("No items", systemImage: "tray")
        } else {
            ContentUnavailableView.search(text: viewModel.searchText)
        }
    }
}