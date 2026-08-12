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
        self.title = category.name.capitalized
        self.icon = .categoryIcon(for: category.name)
    }
}