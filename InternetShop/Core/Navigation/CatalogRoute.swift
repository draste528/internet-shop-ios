//
//  CatalogRoute.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//

import Combine
import Foundation

enum CatalogRoute: Hashable {
    case itemsList(Category)
    case itemDetail(UUID)
}
