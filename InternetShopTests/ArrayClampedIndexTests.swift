//
//  ArrayClampedIndexTests.swift
//  InternetShop
//
//  Created by kair on 03.11.26.
//

import XCTest
@testable import InternetShop

final class ArrayClampedIndexTests: XCTestCase {

    func testEmptyArrayNeverGivesNegativeIndex() {
        let empty: [Int] = []
        XCTAssertEqual(empty.clampedIndex(0), 0)
        XCTAssertEqual(empty.clampedIndex(5), 0)
        XCTAssertEqual(empty.clampedIndex(-3), 0)
    }

    func testIndexInsideRangeIsUnchanged() {
        XCTAssertEqual([1, 2, 3].clampedIndex(1), 1)
    }

    func testOutOfRangeIndexIsClamped() {
        XCTAssertEqual([1, 2, 3].clampedIndex(-1), 0)
        XCTAssertEqual([1, 2, 3].clampedIndex(10), 2)
    }
}
