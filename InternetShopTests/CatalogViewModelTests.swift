//
//  CatalogViewModelTests.swift
//  InternetShop
//
//  Created by kair on 06.08.26.
//

import XCTest
@testable import InternetShop

final class CatalogViewModelTests: XCTestCase {

    func testTitle() {
        let viewModel = CatalogViewModel()
        XCTAssertEqual(viewModel.title, "Catalog")
    }
}
