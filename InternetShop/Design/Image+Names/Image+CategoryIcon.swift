//
//  Image+CategoryIcon.swift
//  InternetShop
//
//  Created by kair on 12.08.26.
//

import SwiftUI

// MARK: - Typed category icons (static, like Font.appName)
extension Image {
    static let categorySofa        = Image("couch")
    static let categoryChair       = Image("Chair")
    static let categoryTable       = Image("Table")
    static let categoryLamp        = Image("Lamp")
    static let categoryBed         = Image("Bed")
    static let categoryWardrobe    = Image("Wardrobe")
    static let categoryPlaceholder = Image("couch")
}

// MARK: - Category kind
// Stable code -> icon + display caption in one place.
enum CategoryKind: String {
    case sofas     = "SOFAS"
    case chairs    = "CHAIRS"
    case tables    = "TABLES"
    case lamps     = "LAMPS"
    case beds      = "BEDS"
    case wardrobes = "WARDROBES"

    var icon: Image {
        switch self {
        case .sofas:     return .categorySofa
        case .chairs:    return .categoryChair
        case .tables:    return .categoryTable
        case .lamps:     return .categoryLamp
        case .beds:      return .categoryBed
        case .wardrobes: return .categoryWardrobe
        }
    }

    // Caption is controlled here — swap to String(localized:) when localisation lands.
    var title: String {
        switch self {
        case .sofas:     return "Sofas"
        case .chairs:    return "Chairs"
        case .tables:    return "Tables"
        case .lamps:     return "Lamps"
        case .beds:      return "Beds"
        case .wardrobes: return "Wardrobes"
        }
    }
}
