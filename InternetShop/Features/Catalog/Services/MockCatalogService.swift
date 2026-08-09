//
//  MockCatalogService.swift
//  InternetShop
//
//  Created by kair on 07.08.26.
//

import Foundation

struct MockCatalogService: CatalogService {
    func fetchCategories() async throws -> [Category] {
        guard let url = Bundle.main.url(forResource: "categories", withExtension: "json") else {
            throw CatalogError.mockNotFound
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Category].self, from: data)
    }
}

enum CatalogError: Error {
    case mockNotFound
}
