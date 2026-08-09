//
//  CatalogViewModelTests.swift
//  InternetShop
//
//  Created by kair on 06.08.26.
//

import XCTest
@testable import InternetShop

private struct StubCatalogService: CatalogService {
    let result: Result<[Category], Error>
    func fetchCategories() async throws -> [Category] {
        try result.get()
    }
}

@MainActor
final class CatalogViewModelTests: XCTestCase {

    private func makeCategory(name: String) -> Category {
        Category(id: UUID(), name: name, thumbnailURL: nil, subCategories: nil)
    }

    func testTitle() {
        XCTAssertEqual(CatalogViewModel().title, "Catalog")
    }

    func testInitialStateIsEmpty() {
        let vm = CatalogViewModel()
        XCTAssertTrue(vm.categories.isEmpty)
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.errorMessage)
    }

    func testLoadCategoriesSuccess() async {
        let stub = StubCatalogService(result: .success([makeCategory(name: "SOFAS")]))
        let vm = CatalogViewModel(service: stub)
        await vm.loadCategories()
        XCTAssertEqual(vm.categories.count, 1)
        XCTAssertNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
    }

    func testLoadCategoriesFailureSetsError() async {
        let stub = StubCatalogService(result: .failure(CatalogError.mockNotFound))
        let vm = CatalogViewModel(service: stub)
        await vm.loadCategories()
        XCTAssertTrue(vm.categories.isEmpty)
        XCTAssertNotNil(vm.errorMessage)
    }
}
