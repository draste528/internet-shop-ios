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

    let router = Router<CatalogRoute>()
    private let service: (any CatalogService)?

    init(serviceLocator: any ServiceLocating = ServiceLocator.shared) {
        self.service = serviceLocator.resolve((any CatalogService).self)
        super.init(title: "Catalog")
    }

    init(service: any CatalogService) {
        self.service = service
        super.init(title: "Catalog")
    }

    var filteredCategories: [Category] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return categories }
        return categories.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    func showDetail(for category: Category) {
        router.push(.itemsList(category: category))
    }

    func loadCategories() async {
        do {
            try await load {
                guard let service else {
                    throw NetworkError.invalidResponse
                }
                self.categories = try await service.fetchCategories()
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
