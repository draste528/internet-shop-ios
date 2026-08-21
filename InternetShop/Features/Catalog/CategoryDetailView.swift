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

    var body: some View {
        VStack(spacing: 0) {
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
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search"
        )
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton { dismiss() }
            }
        }
    }
}
