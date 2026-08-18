//
//  CategoryDetailView.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import SwiftUI

struct CategoryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let viewModel: CategoryDetailViewModel

    // fake (now design), needed for Task 5.
    @State private var searchText = ""
    @FocusState private var searchFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            SearchBar(text: $searchText, isFocused: $searchFocused)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

            SortFilterBar()

            Spacer()
            Text(viewModel.title)
                .font(.appHeadline)
                .foregroundStyle(Color.appBlack)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton { dismiss() }
            }
        }
    }
}
