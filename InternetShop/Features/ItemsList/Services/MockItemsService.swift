//
//  MockItemsService.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//


import Foundation

struct MockItemsService: ItemsService {
    func fetchItems(for category: Category) async throws -> [Item] {
        let filename = category.name.lowercased()
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw ItemsError.mockNotFound
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Item].self, from: data)
    }
}

