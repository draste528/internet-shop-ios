//
//  MockItemDetailsService.swift
//  InternetShop
//
//  Created by kair on 12.10.26.
//

import Foundation

struct MockItemDetailsService: ItemDetailsService {
    func fetchDetails(for itemId: UUID) async throws -> ItemDetails {
        guard let url = Bundle.main.url(forResource: "item-details", withExtension: "json") else {
            throw ItemDetailsError.mockNotFound
        }
        let data = try Data(contentsOf: url)
        // The API returns an array of ItemDetails (see yaml), so we decode an array and pick by id.
        let all = try JSONDecoder().decode([ItemDetails].self, from: data)
        guard let details = all.first(where: { $0.id == itemId }) else {
            throw ItemDetailsError.itemNotFound
        }
        return details
    }
}
