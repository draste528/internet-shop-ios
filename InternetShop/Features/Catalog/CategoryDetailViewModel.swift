//
//  CategoryDetailViewModel.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import Foundation

@MainActor
final class CategoryDetailViewModel: BaseScreenViewModel {
    init(category: Category) {
        let kind = CategoryKind(rawValue: category.name.uppercased())
        super.init(title: kind?.title ?? category.name.capitalized)
    }
}