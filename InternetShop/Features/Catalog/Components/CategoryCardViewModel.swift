//
//  CategoryCardViewModel.swift
//  InternetShop
//
//  Created by kair on 12.08.26.
//


import SwiftUI

struct CategoryCardViewModel {
    let title: String
    let icon: Image

    init(category: Category) {
        let kind = CategoryKind(rawValue: category.name.uppercased())
        self.title = kind?.title ?? category.name.capitalized
        self.icon  = kind?.icon  ?? .categoryPlaceholder
    }
}
