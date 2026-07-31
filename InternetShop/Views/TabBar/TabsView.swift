//
//  TabsView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct TabsView: View {
    
    // MARK: - Properties
    // current Tab
    @State private var selectedTab = 0

    // MARK: - Init
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()

        let itemAppearances = [
            appearance.stackedLayoutAppearance,
            appearance.inlineLayoutAppearance,
            appearance.compactInlineLayoutAppearance
        ]

        for item in itemAppearances {
            item.normal.titleTextAttributes = [
                .foregroundColor: UIColor.appGray
            ]
            
            item.selected.titleTextAttributes = [
                .foregroundColor: UIColor.appPrimary
            ]
        }

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    // MARK: - Body
    var body: some View {
        TabView(selection: $selectedTab) {
            
            CatalogView()
                .tabItem {
                    Image(selectedTab == 0 ? "Collection" : "CollectionInactive")
                        .renderingMode(.original)
                    Text("Catalog")
                }
                .tag(0)

            FavoritesView()
                .tabItem {
                    Image(selectedTab == 1 ? "Heart" : "HeartInactive")
                        .renderingMode(.original)
                    Text("Favorites")
                }
                .tag(1)

            CartView()
                .tabItem {
                    Image(selectedTab == 2 ? "Cart" : "CartInactive")
                        .renderingMode(.original)
                    Text("Cart")
                }
                .tag(2)

            SettingsView()
                .tabItem {
                    Image(selectedTab == 3 ? "Glyph" : "GlyphInactive")
                        .renderingMode(.original)
                    Text("Settings")
                }
                .tag(3)
        }
    }
}

#Preview {
    TabsView()
}
