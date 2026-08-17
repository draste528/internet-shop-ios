//
//  CatalogService.swift
//  InternetShop
//
//  Created by kair on 07.08.26.
//

protocol CatalogService {
    func fetchCategories() async throws -> [Category]
}
