//
//  CatalogRoute.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//

import Foundation

enum CatalogRoute: Hashable {
    case categoryDetail(category: Category)
    case itemsList(category: Category)
    case itemDetail(itemId: UUID)
}
