//
//  ItemsService.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//


import Foundation

protocol ItemsService: Sendable {
    func fetchItems(for category: Category) async throws -> [Item]
}

enum ItemsError: Error {
    case mockNotFound
}