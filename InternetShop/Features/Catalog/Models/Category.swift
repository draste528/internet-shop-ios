//
//  Category.swift
//  InternetShop
//
//  Created by kair on 07.08.26.
//

import Foundation

struct Category: Codable, Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let thumbnailURL: String?
    let subCategories: [Subcategory]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case thumbnailURL = "thumbnailUrl"
        case subCategories
    }
}
