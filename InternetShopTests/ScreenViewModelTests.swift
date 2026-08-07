//
//  ScreenViewModelTests.swift
//  InternetShop
//
//  Created by kair on 03.08.26.
//

import XCTest
@testable import InternetShop

final class ScreenViewModelTests: XCTestCase {
    
    func testBaseScreenViewModelStoresTitle() {

        let viewModel = BaseScreenViewModel(title: "Test")

        XCTAssertEqual(viewModel.title, "Test")
    }
}
