//
//  TabsView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct TabsView: View {

    @StateObject private var menu = SingleSelectionMenuViewModel(items: TabBarItem.allTabs)

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                SingleSelectionMenuView(viewModel: menu)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .padding(.top, 8)
                    .background(Color.appWhite)
                    .overlay(alignment: .top) {
                        Rectangle().fill(Color.appLightGray).frame(height: 1)
                    }
            }
    }
    @ViewBuilder
    private var content: some View {
        switch menu.selectedTag {
        case 0: CatalogView()
        case 1: FavoritesView()
        case 2: CartView()
        case 3: SettingsView()
        default: CatalogView()
        }
    }
}
