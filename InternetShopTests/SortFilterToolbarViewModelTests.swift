//
//  SortFilterToolbarViewModelTests.swift
//  InternetShop
//
//  Created by kair on 03.11.26.
//

import XCTest
@testable import InternetShop

@MainActor
final class SortFilterToolbarViewModelTests: XCTestCase {

    func testNothingAppliedByDefault() {
        let vm = SortFilterToolbarViewModel()
        XCTAssertFalse(vm.isApplied(.sort))
        XCTAssertFalse(vm.isApplied(.filter))
    }

    func testAppliedStateFollowsFlags() {
        let vm = SortFilterToolbarViewModel(isSortApplied: true)
        XCTAssertTrue(vm.isApplied(.sort))
        XCTAssertFalse(vm.isApplied(.filter))

        vm.isFilterApplied = true
        XCTAssertTrue(vm.isApplied(.filter))
    }

    func testTapCallsOnlyMatchingHandler() {
        var sortTaps = 0
        var filterTaps = 0
        let vm = SortFilterToolbarViewModel(
            onSort: { sortTaps += 1 },
            onFilter: { filterTaps += 1 }
        )

        vm.didTap(.sort)
        XCTAssertEqual(sortTaps, 1)
        XCTAssertEqual(filterTaps, 0)

        vm.didTap(.filter)
        XCTAssertEqual(sortTaps, 1)
        XCTAssertEqual(filterTaps, 1)
    }

    func testButtonIconsAndLabels() {
        XCTAssertEqual(SortFilterButtonKind.sort.iconName, "Sorting")
        XCTAssertEqual(SortFilterButtonKind.filter.iconName, "filter")
        XCTAssertEqual(SortFilterButtonKind.sort.accessibilityLabel, "Sort")
        XCTAssertEqual(SortFilterButtonKind.filter.accessibilityLabel, "Filter")
    }
}
