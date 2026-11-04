//
//  Review.swift
//  InternetShop
//
//  Created by kair on 12.10.26.
//

import Foundation

struct Review: Codable, Identifiable, Hashable, Sendable {
    let id: UUID
    let rating: Int
    let message: String?
    let author: String?
}
