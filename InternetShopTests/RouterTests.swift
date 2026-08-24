//
//  RouterTests.swift
//  InternetShop
//
//  Created by kair on 18.08.26.
//


import XCTest
@testable import InternetShop

@MainActor
final class RouterTests: XCTestCase {

    private enum TestRoute: Hashable { case a, b }

    func testPushAppends() {
        let router = Router<TestRoute>()
        router.push(.a)
        router.push(.b)
        XCTAssertEqual(router.path, [.a, .b])
    }

    func testPopRemovesLast() {
        let router = Router<TestRoute>()
        router.push(.a); router.push(.b)
        router.pop()
        XCTAssertEqual(router.path, [.a])
    }

    func testPopOnEmptyIsSafe() {
        let router = Router<TestRoute>()
        router.pop()
        XCTAssertTrue(router.path.isEmpty)
    }

    func testPopToRootClears() {
        let router = Router<TestRoute>()
        router.push(.a); router.push(.b)
        router.popToRoot()
        XCTAssertTrue(router.path.isEmpty)
    }
}