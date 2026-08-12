//
//  Image+CategoryIcon.swift
//  InternetShop
//
//  Created by kair on 12.08.26.
//

import SwiftUI

extension Image {
    static func categoryIcon(for categoryName: String) -> Image {
        Image(categoryIconAssetName(for: categoryName))
    }

    // Icon -> image
    static func categoryIconAssetName(for categoryName: String) -> String {
        switch categoryName.uppercased() {
        case "SOFAS":     return "couch"
        case "CHAIRS":    return "Chair"
        case "TABLES":    return "Table"
        case "LAMPS":     return "Lamp"
        case "BEDS":      return "Bed"
        case "WARDROBES": return "Wardrobe"
        default:          return "couch"
        }
    }
}
