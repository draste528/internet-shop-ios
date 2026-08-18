//
//  LaunchTests.swift
//  InternetShop
//
//  Created by kair on 05.08.26.
//

import XCTest
@testable import InternetShop

@MainActor
final class LaunchViewModelTests: XCTestCase {
    func testStartsNotReady() {
        XCTAssertFalse(LaunchViewModel().isReady)
    }
    func testBecomesReadyAfterJobs() async {
        let vm = LaunchViewModel()
        await vm.runStartupJobs { }
        XCTAssertTrue(vm.isReady)
    }
}

@MainActor
final class AppRouterTests: XCTestCase {
    func testStartsAtLaunch() { XCTAssertEqual(AppRouter().route, .launch) }
    func testShowMain() {
        let r = AppRouter(); r.showMain()
        XCTAssertEqual(r.route, .main)
    }
}
