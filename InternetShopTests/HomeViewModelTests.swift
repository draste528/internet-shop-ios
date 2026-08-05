//
//  HomeViewModelTests.swift
//  InternetShop
//
//  Created by kair on 05.08.26.
//

import XCTest
@testable import InternetShop

@MainActor
final class HomeViewModelTests: XCTestCase {

    func testInitialStateHidesTabs() {
        let viewModel = HomeViewModel()
        XCTAssertFalse(viewModel.showTabs)
    }

    func testStartShoppingShowsTabs() {
        let viewModel = HomeViewModel()
        viewModel.startShopping()
        XCTAssertTrue(viewModel.showTabs)
    }
}
