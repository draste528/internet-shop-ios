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

    private func makeReview(_ rating: Int) -> Review {
        Review(id: UUID(), rating: rating, message: "msg", author: "Author")
    }

    private func makeDetails(
        thumbnails: [String]? = ["https://example.com/1.jpg", ""],
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

    func testImageURLsKeepsInvalidAsNil() async {
        let vm = makeViewModel(.success(makeDetails()))
        await vm.loadDetails()
        XCTAssertEqual(vm.imageURLs.count, 2)
        XCTAssertNotNil(vm.imageURLs[0])
        XCTAssertNil(vm.imageURLs[1])
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

    func testReviewNavigationIsClamped() async {
        let vm = makeViewModel(.success(makeDetails(reviews: [makeReview(1), makeReview(4)])))
        await vm.loadDetails()
        XCTAssertFalse(vm.canShowPreviousReview)
        XCTAssertTrue(vm.canShowNextReview)

        vm.showPreviousReview()
        XCTAssertEqual(vm.currentReview?.rating, 1)

        vm.showNextReview()
        XCTAssertEqual(vm.currentReview?.rating, 4)
        XCTAssertFalse(vm.canShowNextReview)

        vm.showNextReview()
        XCTAssertEqual(vm.currentReview?.rating, 4)
    }

    func testNoReviews() async {
        let vm = makeViewModel(.success(makeDetails(reviews: nil)))
        await vm.loadDetails()
        XCTAssertNil(vm.currentReview)
        XCTAssertFalse(vm.canShowNextReview)
    }
}
