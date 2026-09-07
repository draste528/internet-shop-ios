//
//  StubItemsService.swift
//  InternetShop
//
//  Created by kair on 07.09.26.
//


import XCTest
@testable import InternetShop

private struct StubItemsService: ItemsService {
    let result: Result<[Item], Error>
    func fetchItems(for category: InternetShop.Category) async throws -> [Item] {
        try result.get()
    }
}

@MainActor
final class ItemsListViewModelTests: XCTestCase {

    private func makeCategory() -> InternetShop.Category {
        Category(id: UUID(), name: "SOFAS", thumbnailURL: nil, subCategories: nil)
    }
    
    private func makeItem(name: String) -> Item {
        Item(id: UUID(), name: name, price: 99.9, rating: 5.0, thumbnailURL: nil, categoryId: UUID())
    }

    func testTitleMatchesCategory() {
        let vm = ItemsListViewModel(category: makeCategory())
        XCTAssertEqual(vm.title, "Sofas")
    }

    func testInitialState() {
        let vm = ItemsListViewModel(category: makeCategory())
        XCTAssertTrue(vm.items.isEmpty)
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.errorMessage)
    }

    func testLoadItemsSuccess() async {
        let stub = StubItemsService(result: .success([makeItem(name: "Big Sofa")]))
        let vm = ItemsListViewModel(category: makeCategory(), service: stub)
        
        await vm.loadItems()
        
        XCTAssertEqual(vm.items.count, 1)
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.errorMessage)
    }

    func testLoadItemsFailureSetsError() async {
        let stub = StubItemsService(result: .failure(ItemsError.mockNotFound))
        let vm = ItemsListViewModel(category: makeCategory(), service: stub)
        
        await vm.loadItems()
        
        XCTAssertTrue(vm.items.isEmpty)
        XCTAssertNotNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
    }
    
    func testFilterByNameIsCaseInsensitive() async {
        let stub = StubItemsService(result: .success([
            makeItem(name: "Leather Sofa"), 
            makeItem(name: "Fabric Chair")
        ]))
        let vm = ItemsListViewModel(category: makeCategory(), service: stub)
        
        await vm.loadItems()
        vm.searchText = "leather"
        
        XCTAssertEqual(vm.filteredItems.map(\.name), ["Leather Sofa"])
    }
}