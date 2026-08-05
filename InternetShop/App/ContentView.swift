//
//  ContentView.swift
//  InternetShop
//
//  Created by kair on 26.07.26.
//

import SwiftUI

struct ContentView: View {
    @State private var showTabs = false
    var body: some View {
        if showTabs {
            TabsView()
        } else {
            HomeView(onStart: { showTabs = true })
        }
    }
}

#Preview {
    ContentView()
}
