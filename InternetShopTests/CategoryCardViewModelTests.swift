//
//  CategoryCardViewModelTests.swift
//  InternetShop
//
//  Created by kair on 12.08.26.
//

import XCTest
@testable import InternetShop

final class CategoryCardViewModelTests: XCTestCase {

    private func makeCategory(name: String) -> InternetShop.Category {
        InternetShop.Category(id: UUID(), name: name, thumbnailURL: nil, subCategories: nil)
    }

    func testTitleIsCapitalizedCategoryName() {
        let viewModel = CategoryCardViewModel(category: makeCategory(name: "SOFAS"))
        XCTAssertEqual(viewModel.title, "Sofas")
    }

    func testTitleCapitalizesEachWord() {
        let viewModel = CategoryCardViewModel(category: makeCategory(name: "CORNER SOFAS"))
        XCTAssertEqual(viewModel.title, "Corner Sofas")
    }
}
