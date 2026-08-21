//
//  RootViewModelTests.swift
//  InternetShop
//
//  Created by kair on 21.08.26.
//


import XCTest
@testable import InternetShop

@MainActor
final class RootViewModelTests: XCTestCase {
    func testStartsAtLaunch() {
        XCTAssertEqual(RootViewModel().route, .launch)
    }
    func testShowMainSwitchesToMain() {
        let vm = RootViewModel()
        vm.showMain()
        XCTAssertEqual(vm.route, .main)
    }
}