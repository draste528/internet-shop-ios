//
//  CategoryDetailViewModelTests.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import XCTest
@testable import InternetShop

@MainActor
final class CategoryDetailViewModelTests: XCTestCase {

    func testTitleFromKnownCategoryKind() {
        let category = Category(id: UUID(), name: "SOFAS", thumbnailURL: nil, subCategories: nil)
        let vm = CategoryDetailViewModel(category: category)
        XCTAssertEqual(vm.title, "Sofas")
    }

    func testTitleFromUnknownCategoryName() {
        let category = Category(id: UUID(), name: "MIRRORS", thumbnailURL: nil, subCategories: nil)
        let vm = CategoryDetailViewModel(category: category)
        XCTAssertEqual(vm.title, "Mirrors")
    }

    func testTitleWithLowercaseAndSpaces() {
        let category = Category(id: UUID(), name: "corner sofas", thumbnailURL: nil, subCategories: nil)
        let vm = CategoryDetailViewModel(category: category)
        XCTAssertEqual(vm.title, "Corner Sofas")
    }
}
