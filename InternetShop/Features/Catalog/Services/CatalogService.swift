//
//  CatalogService.swift
//  InternetShop
//
//  Created by kair on 07.08.26.
//

import Foundation

protocol CatalogService: Sendable {
    func fetchCategories() async throws -> [Category]
}
