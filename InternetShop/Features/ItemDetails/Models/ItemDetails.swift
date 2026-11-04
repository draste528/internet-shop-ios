//
//  ItemDetails.swift
//  InternetShop
//
//  Created by kair on 12.10.26.
//

import Foundation

struct ItemDetails: Codable, Identifiable, Hashable, Sendable {
    let id: UUID
    let name: String
    let category: Category
    let subCategory: Subcategory
    let description: String
    let rating: Int
    let isFavorited: Bool
    let isAddedToCart: Bool
    let price: String
    let thumbnails: [String]?
    let reviews: [Review]?
}
