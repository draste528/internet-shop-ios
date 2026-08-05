//
//  ScreenViewModelTests.swift
//  InternetShop
//
//  Created by kair on 03.08.26.
//

import XCTest
@testable import InternetShop

final class ScreenViewModelTests: XCTestCase {

    // MARK: - Catalog
    func testCatalogTitle() {
        let viewModel = CatalogViewModel()
        XCTAssertEqual(viewModel.title, "Catalog")
    }

    // MARK: - Favorites
    func testFavoritesTitle() {
        let viewModel = FavoritesViewModel()
        XCTAssertEqual(viewModel.title, "Favorites")
    }

    // MARK: - Cart
    func testCartTitle() {
        let viewModel = CartViewModel()
        XCTAssertEqual(viewModel.title, "Cart")
    }

    // MARK: - Settings
    func testSettingsTitle() {
        let viewModel = SettingsViewModel()
        XCTAssertEqual(viewModel.title, "Settings")
    }
    
    // MARK: - BaseScreenViewModel
    func testBaseScreenViewModelStoresTitle() {

        let viewModel = BaseScreenViewModel(title: "Test")

        XCTAssertEqual(viewModel.title, "Test")
    }
}
