import XCTest
@testable import InternetShop

private struct StubCatalogService: CatalogService {
    let result: Result<[InternetShop.Category], Error>
    func fetchCategories() async throws -> [InternetShop.Category] {
        try result.get()
    }
}

@MainActor
final class CatalogViewModelTests: XCTestCase {

    private func makeCategory(name: String) -> InternetShop.Category {
        Category(id: UUID().uuidString, name: name, thumbnailURL: nil, subCategories: nil)
    }

    func testTitle() {
        let stub = StubCatalogService(result: .success([]))
        XCTAssertEqual(CatalogViewModel(service: stub).title, "Catalog")
    }

    func testInitialStateIsEmpty() {
        let stub = StubCatalogService(result: .success([]))
        let viewModel = CatalogViewModel(service: stub)
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
        let stub = StubCatalogService(result: .failure(NetworkError.statusCode(500)))
        let viewModel = CatalogViewModel(service: stub)
        await viewModel.loadCategories()
        XCTAssertTrue(viewModel.categories.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, NetworkError.statusCode(500).localizedDescription)
        XCTAssertTrue(viewModel.isShowingError)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testResolvesServiceFromServiceLocator() async {
        let locator = ServiceLocator()
        let stub: any CatalogService = StubCatalogService(result: .success([makeCategory(name: "LAMPS")]))
        locator.register(stub, for: (any CatalogService).self)

        let viewModel = CatalogViewModel(serviceLocator: locator)
        await viewModel.loadCategories()
        XCTAssertEqual(viewModel.categories.map(\.name), ["LAMPS"])
    }

    func testMissingServiceInLocatorSetsError() async {
        let locator = ServiceLocator()
        let viewModel = CatalogViewModel(serviceLocator: locator)
        await viewModel.loadCategories()
        XCTAssertTrue(viewModel.categories.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func testFilterByNameIsCaseInsensitive() async {
        let stub = StubCatalogService(result: .success([
            makeCategory(name: "SOFAS"), makeCategory(name: "CHAIRS")
        ]))
        let viewModel = CatalogViewModel(service: stub)
        await viewModel.loadCategories()
        viewModel.searchText = "sof"
        XCTAssertEqual(viewModel.filteredCategories.map(\.name), ["SOFAS"])
    }

    func testEmptySearchReturnsAll() async {
        let stub = StubCatalogService(result: .success([
            makeCategory(name: "SOFAS"), makeCategory(name: "CHAIRS")
        ]))
        let viewModel = CatalogViewModel(service: stub)
        await viewModel.loadCategories()
        viewModel.searchText = "   "
        XCTAssertEqual(viewModel.filteredCategories.count, 2)
    }

    func testShowDetailPushesRoute() {
        let stub = StubCatalogService(result: .success([]))
        let vm = CatalogViewModel(service: stub)
        let category = makeCategory(name: "SOFAS")
        vm.showDetail(for: category)
        XCTAssertEqual(vm.router.path, [.itemsList(category: category)])
    }
}
