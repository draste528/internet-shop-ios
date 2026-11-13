import XCTest
@testable import InternetShop

private struct StubNetworkClient: NetworkClientProtocol {
    let result: Result<[InternetShop.Category], Error>

    func request<T: Decodable & Sendable>(_ endpoint: any Endpoint) async throws -> T {
        XCTAssertEqual(endpoint.path, "/api/v1/categories")
        XCTAssertEqual(endpoint.method, .get)
        let categories = try result.get()
        guard let typed = categories as? T else {
            throw NetworkError.decodingFailed
        }
        return typed
    }
}

final class CategoryServiceTests: XCTestCase {
    func testFetchCategoriesSuccess() async throws {
        let expected = [
            Category(
                id: "1",
                name: "Sofas",
                thumbnailURL: nil,
                subCategories: [Subcategory(id: "7", name: "Kitchen sofas", thumbnailURL: nil)]
            )
        ]
        let service = CategoryService(networkClient: StubNetworkClient(result: .success(expected)))

        let categories = try await service.fetchCategories()
        XCTAssertEqual(categories, expected)
    }

    func testFetchCategoriesPropagatesError() async {
        let service = CategoryService(networkClient: StubNetworkClient(result: .failure(NetworkError.statusCode(500))))

        do {
            _ = try await service.fetchCategories()
            XCTFail("Expected error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .statusCode(500))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
