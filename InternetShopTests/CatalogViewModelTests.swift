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
        let viewModel = CatalogViewModel()
        XCTAssertTrue(viewModel.categories.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoadCategoriesSuccess() async {
        let stub = StubCatalogService(result: .success([makeCategory(name: "SOFAS")]))
        let viewModel = CatalogViewModel(service: stub)
        await viewModel.loadCategories()
        XCTAssertEqual(viewModel.categories.count, 1)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadCategoriesFailureSetsError() async {
        let stub = StubCatalogService(result: .failure(CatalogError.mockNotFound))
        let viewModel = CatalogViewModel(service: stub)
        await viewModel.loadCategories()
        XCTAssertTrue(viewModel.categories.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
}
