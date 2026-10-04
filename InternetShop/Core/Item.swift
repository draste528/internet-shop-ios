//
//  Item.swift
//  InternetShop
//
//  Created by kair on 26.07.26.
//

import Foundation

struct Item: Codable, Identifiable, Hashable, Sendable {
    let id: UUID
    let name: String
    let category: Category
    let subCategory: Subcategory
    let rating: Int
    let isFavorited: Bool
    let isAddedToCart: Bool
    let price: String
    let thumbnailURL: String?

    var priceValue: Double {
        Double(price) ?? 0.0
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case subCategory
        case rating
        case isFavorited
        case isAddedToCart
        case price
        case thumbnailURL = "thumbnailurl"
    }
}
