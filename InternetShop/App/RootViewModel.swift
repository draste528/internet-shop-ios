//
//  RootViewModel.swift
//  InternetShop
//
//  Created by kair on 20.08.26.
//


import Combine

@MainActor
final class RootViewModel: ObservableObject {
    @Published private(set) var route: AppRoute = .launch

    let catalogViewModel: CatalogViewModel
    let launchViewModel: LaunchViewModel

    init(catalogViewModel: CatalogViewModel? = nil) {
        let catalog = catalogViewModel ?? CatalogViewModel()
        self.catalogViewModel = catalog
        self.launchViewModel = LaunchViewModel(catalogViewModel: catalog)
    }

    func showMain() { route = .main }
}
