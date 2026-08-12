//
//  CategoryIconTests.swift
//  InternetShop
//
//  Created by kair on 12.08.26.
//


import XCTest
import SwiftUI
@testable import InternetShop

final class CategoryIconTests: XCTestCase {

    func testKnownCategoriesMapToExpectedAssets() {
        XCTAssertEqual(Image.categoryIconAssetName(for: "SOFAS"), "couch")
        XCTAssertEqual(Image.categoryIconAssetName(for: "CHAIRS"), "Chair")
        XCTAssertEqual(Image.categoryIconAssetName(for: "TABLES"), "Table")
        XCTAssertEqual(Image.categoryIconAssetName(for: "LAMPS"), "Lamp")
        XCTAssertEqual(Image.categoryIconAssetName(for: "BEDS"), "Bed")
        XCTAssertEqual(Image.categoryIconAssetName(for: "WARDROBES"), "Wardrobe")
    }

    func testMappingIsCaseInsensitive() {
        XCTAssertEqual(Image.categoryIconAssetName(for: "sofas"), "couch")
    }

    func testUnknownCategoryFallsBackToDefault() {
        XCTAssertEqual(Image.categoryIconAssetName(for: "MIRRORS"), "couch")
    }
}