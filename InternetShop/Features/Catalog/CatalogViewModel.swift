//
//  CatalogViewModel.swift
//  InternetShop
//
//  Created by kair on 29.07.26.
//

import Foundation
import Combine

@MainActor
final class CatalogViewModel: BaseScreenViewModel {

    @Published private(set) var categories: [Category] = []
    @Published var searchText = ""

    let router = Router<CatalogRoute>()

    private let service: CatalogService

    init(service: CatalogService = MockCatalogService()) {
        self.service = service
        super.init(title: "Catalog")
    }

    var filteredCategories: [Category] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return categories }
        return categories.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    func showDetail(for category: Category) {
            router.push(.itemsList(category))
    }

    func loadCategories() async {
        await load { self.categories = try await self.service.fetchCategories() }
    }
}
