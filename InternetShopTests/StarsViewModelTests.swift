//
//  StarsViewModelTests.swift
//  InternetShop
//
//  Created by kair on 12.10.26.
//

import XCTest
@testable import InternetShop

final class StarsViewModelTests: XCTestCase {

    func testFullHalfAndEmptyIcons() {
        let vm = StarsViewModel(rating: 3.5)
        let icons = (0..<vm.maxRating).map { vm.iconName(for: $0) }
        XCTAssertEqual(icons, ["star.fill", "star.fill", "star.fill", "star.leadinghalf.filled", "star"])
    }

    func testZeroRatingIsAllEmpty() {
        let vm = StarsViewModel(rating: 0)
        XCTAssertTrue((0..<vm.maxRating).allSatisfy { vm.iconName(for: $0) == "star" })
    }

    func testMaxRatingIsAllFull() {
        let vm = StarsViewModel(rating: 5)
        XCTAssertTrue((0..<vm.maxRating).allSatisfy { vm.iconName(for: $0) == "star.fill" })
    }

    func testCustomMaxRating() {
        XCTAssertEqual(StarsViewModel(rating: 1, maxRating: 3).maxRating, 3)
    }
}
