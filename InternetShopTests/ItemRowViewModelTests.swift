//
//  ItemRowViewModelTests.swift
//  InternetShop
//
//  Created by kair on 12.10.26.
//

import XCTest
@testable import InternetShop

@MainActor
final class ItemRowViewModelTests: XCTestCase {

    private func makeItem(price: String = "99.9", thumbnailURL: String? = nil) -> Item {
        Item(
            id: UUID(),
            name: "Sofa",
            category: InternetShop.Category(id: UUID(), name: "SOFAS", thumbnailURL: nil, subCategories: nil),
            subCategory: Subcategory(id: UUID(), name: "Sub", thumbnailURL: nil),
            rating: 4,
            isFavorited: false,
            isAddedToCart: false,
            price: price,
            thumbnailURL: thumbnailURL
        )
    }

    func testPriceFormatted() {
        XCTAssertEqual(ItemRowViewModel(item: makeItem(price: "450")).priceFormatted, "450.00 $")
    }

    func testInvalidPriceFallsBackToZero() {
        XCTAssertEqual(ItemRowViewModel(item: makeItem(price: "abc")).priceFormatted, "0.00 $")
    }

    func testImageURLNilWhenMissingOrEmpty() {
        XCTAssertNil(ItemRowViewModel(item: makeItem(thumbnailURL: nil)).imageURL)
        XCTAssertNil(ItemRowViewModel(item: makeItem(thumbnailURL: "")).imageURL)
    }

    func testImageURLNilForNonHttpString() {
        XCTAssertNil(ItemRowViewModel(item: makeItem(thumbnailURL: "not a link")).imageURL)
    }

    func testImageURLForValidLink() {
        let vm = ItemRowViewModel(item: makeItem(thumbnailURL: "https://picsum.photos/id/1/200/200"))
        XCTAssertEqual(vm.imageURL?.absoluteString, "https://picsum.photos/id/1/200/200")
    }
}
