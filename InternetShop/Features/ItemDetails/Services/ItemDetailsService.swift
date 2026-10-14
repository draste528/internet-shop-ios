//
//  ItemDetailsService.swift
//  InternetShop
//
//  Created by kair on 12.10.26.
//

import Foundation

protocol ItemDetailsService: Sendable {
    func fetchDetails(for itemId: UUID) async throws -> ItemDetails
}

enum ItemDetailsError: Error {
    case mockNotFound
    case itemNotFound
}
