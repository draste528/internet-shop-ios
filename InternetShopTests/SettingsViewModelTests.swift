//
//  SettingsViewModelTests.swift
//  InternetShop
//
//  Created by kair on 06.08.26.
//

import XCTest
@testable import InternetShop

final class SettingsViewModelTests: XCTestCase {

    func testTitle() {
        let viewModel = SettingsViewModel()
        XCTAssertEqual(viewModel.title, "Settings")
    }
}
