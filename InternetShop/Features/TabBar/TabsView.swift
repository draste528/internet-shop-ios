//
//  TabsView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct TabsView: View {
    let catalogViewModel: CatalogViewModel
    @StateObject private var menu = SingleSelectionMenuViewModel(items: TabBarItem.allTabs)

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                SingleSelectionMenuView(viewModel: menu)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .padding(.top, 8)
                    .background(Color.appDisabled)
                    .overlay(alignment: .top) {
                        Rectangle().fill(Color.appLightGray)
                            .frame(height: 1)
                    }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    @ViewBuilder
    private var content: some View {
        switch menu.selectedTag {
        case 0: CatalogView(viewModel: catalogViewModel)
        case 1: FavoritesView()
        case 2: CartView()
        case 3: SettingsView()
        default: CatalogView(viewModel: catalogViewModel)
        }
    }
}
