//
//  TabsView.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import SwiftUI

struct TabsView: View {

    var body: some View {

        TabView {

            CatalogView()
                .tabItem {
                    Image("Collection")
                    Text("Catalog")
                }


            FavoritesView()
                .tabItem {
                    Image("Heart")
                    Text("Favorites")
                }


            CartView()
                .tabItem {
                    Image("Cart")
                    Text("Cart")
                }


            SettingsView()
                .tabItem {
                    Image("Glyph")
                    Text("Settings")
                }
        }
        .tint(Color.appPrimary)
    }
}


#Preview {
    TabsView()
}
