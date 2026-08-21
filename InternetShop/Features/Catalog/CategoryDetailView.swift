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

    @State private var searchText = ""
    @FocusState private var searchFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            Rectangle().fill(Color.appLightGray).frame(height: 1)

            SearchBar(text: $searchText, isFocused: $searchFocused)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

            Rectangle().fill(Color.appLightGray).frame(height: 1)

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
