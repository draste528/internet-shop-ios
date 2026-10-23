//
//  ItemDetailViewModelTests.swift
//  InternetShop
//
//  Created by kair on 12.10.26.
//

import XCTest
@testable import InternetShop

private struct StubItemDetailsService: ItemDetailsService {
    let result: Result<ItemDetails, Error>
    func fetchDetails(for itemId: UUID) async throws -> ItemDetails {
        try result.get()
    }
}

@MainActor
final class ItemDetailViewModelTests: XCTestCase {

    private func makeDetails(
        thumbnails: [String]? = ["https://example.com/1.jpg", "", "not a link"],
        reviews: [Review]? = nil,
        favorited: Bool = false,
        inCart: Bool = false
    ) -> ItemDetails {
        ItemDetails(
            id: UUID(),
            name: "VINDKAST",
            category: InternetShop.Category(id: UUID(), name: "LAMPS", thumbnailURL: nil, subCategories: nil),
            subCategory: Subcategory(id: UUID(), name: "Pendant lamps", thumbnailURL: nil),
            description: "Desc",
            rating: 2,
            isFavorited: favorited,
            isAddedToCart: inCart,
            price: "2.59",
            thumbnails: thumbnails,
            reviews: reviews
        )
    }

    private func makeViewModel(_ result: Result<ItemDetails, Error>) -> ItemDetailViewModel {
        ItemDetailViewModel(itemId: UUID(), service: StubItemDetailsService(result: result))
    }

    func testInitialState() {
        let vm = makeViewModel(.success(makeDetails()))
        XCTAssertNil(vm.details)
        XCTAssertEqual(vm.navigationTitle, "")
        XCTAssertTrue(vm.imageURLs.isEmpty)
        XCTAssertTrue(vm.reviews.isEmpty)
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.errorMessage)
    }

    func testLoadSuccessSetsDetailsAndFlags() async {
        let vm = makeViewModel(.success(makeDetails(favorited: true, inCart: true)))
        await vm.loadDetails()
        XCTAssertEqual(vm.navigationTitle, "VINDKAST")
        XCTAssertTrue(vm.isFavorited)
        XCTAssertTrue(vm.isAddedToCart)
        XCTAssertNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
    }

    func testLoadFailureSetsError() async {
        let vm = makeViewModel(.failure(ItemDetailsError.itemNotFound))
        await vm.loadDetails()
        XCTAssertNil(vm.details)
        XCTAssertNotNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
    }

    func testImageURLsContainOnlyValidLinks() async {
        let vm = makeViewModel(.success(makeDetails()))
        await vm.loadDetails()
        XCTAssertEqual(vm.imageURLs.map(\.absoluteString), ["https://example.com/1.jpg"])
    }

    func testImageURLsEmptyWhenNoThumbnails() async {
        let vm = makeViewModel(.success(makeDetails(thumbnails: nil)))
        await vm.loadDetails()
        XCTAssertTrue(vm.imageURLs.isEmpty)
    }

    func testToggles() async {
        let vm = makeViewModel(.success(makeDetails()))
        await vm.loadDetails()
        vm.toggleFavorite()
        vm.toggleCart()
        XCTAssertTrue(vm.isFavorited)
        XCTAssertTrue(vm.isAddedToCart)
        vm.toggleFavorite()
        XCTAssertFalse(vm.isFavorited)
    }

    func testBuyAddsToCart() async {
        let vm = makeViewModel(.success(makeDetails()))
        await vm.loadDetails()
        vm.buy()
        XCTAssertTrue(vm.isAddedToCart)
    }

    func testReviewsExposed() async {
        let vm = makeViewModel(.success(makeDetails(reviews: [makeReview(1), makeReview(4)])))
        await vm.loadDetails()
        XCTAssertEqual(vm.reviews.map(\.rating), [1, 4])
    }

    func testNoReviews() async {
        let vm = makeViewModel(.success(makeDetails(reviews: nil)))
        await vm.loadDetails()
        XCTAssertTrue(vm.reviews.isEmpty)
    }

}
