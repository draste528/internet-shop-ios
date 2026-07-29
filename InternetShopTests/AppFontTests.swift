//
//  AppFontTests.swift
//  InternetShop
//
//  Created by kair on 26.07.26.
//

import XCTest
import SwiftUI
@testable import InternetShop

final class AppFontTests: XCTestCase {

    func testAppName() {
        XCTAssertEqual(Font.appName, .system(size: 20, weight: .bold))
    }

    func testHeadline() {
        XCTAssertEqual(Font.appHeadline, .system(size: 17, weight: .semibold))
    }

    func testInput() {
        XCTAssertEqual(Font.appInput, .system(size: 16, weight: .regular))
    }

    func testCardTitle() {
        XCTAssertEqual(Font.appCardTitle, .system(size: 15, weight: .regular))
    }

    func testBody() {
        XCTAssertEqual(Font.appBody, .system(size: 15, weight: .regular))
    }

    func testBodySemibold() {
        XCTAssertEqual(Font.appBodySemibold, .system(size: 15, weight: .semibold))
    }

    func testCaption() {
        XCTAssertEqual(Font.appCaption, .system(size: 12, weight: .regular))
    }
}
