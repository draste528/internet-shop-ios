//
//  CartViewModelTests.swift
//  InternetShop
//
//  Created by kair on 06.08.26.
//

import XCTest
@testable import InternetShop

final class CartViewModelTests: XCTestCase {

    func testTitle() {
        let viewModel = CartViewModel()
        XCTAssertEqual(viewModel.title, "Cart")
    }
}
