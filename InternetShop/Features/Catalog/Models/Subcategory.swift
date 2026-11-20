//
//  Subcategory.swift
//  InternetShop
//
//  Created by kair on 07.08.26.
//

import Foundation

nonisolated struct Subcategory: Codable, Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case thumbnailURL = "thumbnailUrl"
    }
}
