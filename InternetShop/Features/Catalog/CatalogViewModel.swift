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
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let service: CatalogService

    init(service: CatalogService = MockCatalogService()) {
        self.service = service
        super.init(title: "Catalog")
    }

    func loadCategories() async {
        isLoading = true
        errorMessage = nil
        do {
            categories = try await service.fetchCategories()
        } catch {
            errorMessage = "Failed to load categories"
        }
        isLoading = false
    }
}
