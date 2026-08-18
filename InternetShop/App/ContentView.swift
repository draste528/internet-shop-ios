//
//  ContentView.swift
//  InternetShop
//
//  Created by kair on 26.07.26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appRouter = AppRouter()
    @StateObject private var catalogViewModel = CatalogViewModel()

    var body: some View {
        switch appRouter.route {
        case .launch:
            LaunchView(
                startupJobs: { await catalogViewModel.loadCategories() },
                onContinue: { appRouter.showMain() }
            )
        case .main:
            TabsView(catalogViewModel: catalogViewModel)
        }
    }
}
