//
//  FavoritesViewModelTests.swift
//  InternetShop
//
//  Created by kair on 06.08.26.
//

import XCTest
@testable import InternetShop

final class FavoritesViewModelTests: XCTestCase {

    func testTitle() {
        let viewModel = FavoritesViewModel()
        XCTAssertEqual(viewModel.title, "Favorites")
    }
}
