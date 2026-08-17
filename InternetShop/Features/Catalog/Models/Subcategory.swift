//
//  Subcategory.swift
//  InternetShop
//
//  Created by kair on 07.08.26.
//

import Foundation

struct Subcategory: Codable, Identifiable, Hashable {
    let id: UUID
    let name: String
    let thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case thumbnailURL = "thumbnailurl"
    }
}

