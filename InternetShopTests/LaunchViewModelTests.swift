//
//  LaunchViewModelTests.swift
//  InternetShop
//
//  Created by kair on 05.08.26.
//


import XCTest
@testable import InternetShop


@MainActor
final class LaunchViewModelTests: XCTestCase {
    func testStartsNotReady() {
        XCTAssertFalse(LaunchViewModel(catalogViewModel: CatalogViewModel()).isReady)
    }
    func testBecomesReadyAfterJobs() async {
        let vm = LaunchViewModel(catalogViewModel: CatalogViewModel())
        await vm.runStartupJobs()
        XCTAssertTrue(vm.isReady)
    }
}

