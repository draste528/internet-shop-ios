//
//  LaunchViewModel.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import Combine

@MainActor
final class LaunchViewModel: ObservableObject {
    @Published private(set) var isReady = false

    private let catalogViewModel: CatalogViewModel

    init(catalogViewModel: CatalogViewModel) {
        self.catalogViewModel = catalogViewModel
    }

    func runStartupJobs() async {
        await catalogViewModel.loadCategories()
        isReady = true
    }
}
