//
//  SingleSelectionMenuItem.swift
//  InternetShop
//
//  Created by kair on 04.08.26.
//

import SwiftUI

protocol SingleSelectionMenuItem {
    var icon: String { get }          // имя ассета (template)
    var title: String { get }
    var activeColor: Color { get }
    var inactiveColor: Color { get }
    var tag: Int { get }
}

extension TabBarItem {
    static let allTabs: [any SingleSelectionMenuItem] = [
        TabBarItem(icon: "Collection", title: "Catalog",   activeColor: .appPrimary, inactiveColor: .appGray, tag: 0),
        TabBarItem(icon: "Heart",      title: "Favorites",  activeColor: .appPrimary, inactiveColor: .appGray, tag: 1),
        TabBarItem(icon: "Cart",       title: "Cart",       activeColor: .appPrimary, inactiveColor: .appGray, tag: 2),
        TabBarItem(icon: "Glyph",      title: "Settings",   activeColor: .appPrimary, inactiveColor: .appGray, tag: 3),
    ]
}
