//
//  SingleSelectionMenuViewModelTests.swift
//  InternetShop
//
//  Created by kair on 05.08.26.
//

import XCTest
import SwiftUI
@testable import InternetShop

final class SingleSelectionMenuViewModelTests: XCTestCase {

    private func makeItems() -> [any SingleSelectionMenuItem] {
        [
            TabBarItem(icon: "a", title: "A", activeColor: .appPrimary, inactiveColor: .appGray, tag: 0),
            TabBarItem(icon: "b", title: "B", activeColor: .appPrimary, inactiveColor: .appGray, tag: 1),
            TabBarItem(icon: "c", title: "C", activeColor: .appPrimary, inactiveColor: .appGray, tag: 2),
        ]
    }

    func testDefaultsToFirstItemTag() {
        XCTAssertEqual(SingleSelectionMenuViewModel(items: makeItems()).selectedTag, 0)
    }

    func testRespectsProvidedSelectedTag() {
        XCTAssertEqual(SingleSelectionMenuViewModel(items: makeItems(), selectedTag: 2).selectedTag, 2)
    }

    func testItemAtValidIndex() {
        XCTAssertEqual(SingleSelectionMenuViewModel(items: makeItems()).item(at: 1)?.tag, 1)
    }

    func testItemAtInvalidIndexIsNil() {
        XCTAssertNil(SingleSelectionMenuViewModel(items: makeItems()).item(at: 99))
    }

    func testItemWithTag() {
        XCTAssertEqual(SingleSelectionMenuViewModel(items: makeItems()).item(withTag: 2)?.title, "C")
    }

    func testIsSelected() {
        let vm = SingleSelectionMenuViewModel(items: makeItems(), selectedTag: 1)
        XCTAssertTrue(vm.isSelected(vm.item(withTag: 1)!))
    }

    func testColorForSelectedIsActive() {
        let vm = SingleSelectionMenuViewModel(items: makeItems(), selectedTag: 0)
        let item = vm.item(withTag: 0)!
        XCTAssertEqual(vm.color(for: item), item.activeColor)
    }

    func testColorForUnselectedIsInactive() {
        let vm = SingleSelectionMenuViewModel(items: makeItems(), selectedTag: 0)
        let item = vm.item(withTag: 1)!
        XCTAssertEqual(vm.color(for: item), item.inactiveColor)
    }

    func testSelectUpdatesSelectedTag() {
        let vm = SingleSelectionMenuViewModel(items: makeItems())
        vm.select(vm.item(withTag: 2)!)
        XCTAssertEqual(vm.selectedTag, 2)
    }
}
