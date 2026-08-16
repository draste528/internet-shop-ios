//
//  CategoryIconTests.swift
//  InternetShop
//
//  Created by kair on 12.08.26.
//

import XCTest
@testable import InternetShop

final class CategoryKindTests: XCTestCase {

    func testKnownCodesMapToKind() {
        XCTAssertEqual(CategoryKind(rawValue: "SOFAS"), .sofas)
        XCTAssertEqual(CategoryKind(rawValue: "CHAIRS"), .chairs)
        XCTAssertEqual(CategoryKind(rawValue: "TABLES"), .tables)
        XCTAssertEqual(CategoryKind(rawValue: "LAMPS"), .lamps)
        XCTAssertEqual(CategoryKind(rawValue: "BEDS"), .beds)
        XCTAssertEqual(CategoryKind(rawValue: "WARDROBES"), .wardrobes)
    }

    func testUnknownCodeIsNil() {
        XCTAssertNil(CategoryKind(rawValue: "MIRRORS"))
    }

    func testTitles() {
        XCTAssertEqual(CategoryKind.sofas.title, "Sofas")
        XCTAssertEqual(CategoryKind.wardrobes.title, "Wardrobes")
    }
}
