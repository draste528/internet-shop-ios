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
        ZStack(alignment: .bottom) {
            content
            SingleSelectionMenuView(viewModel: menu)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.appWhite)
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
