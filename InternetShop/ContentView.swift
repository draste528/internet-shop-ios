//
//  ContentView.swift
//  InternetShop
//
//  Created by kair on 26.07.26.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Properties

    @State private var showTabs = false

    // MARK: - Body

    var body: some View {
        if showTabs {
            TabsView()
        } else {
            HomeView(showTabs: $showTabs)
        }
    }
}

#Preview {
    ContentView()
}
