import Foundation

struct CategoryService: CatalogService {
    private let networkClient: any NetworkClientProtocol

    init(networkClient: any NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }

    func fetchCategories() async throws -> [Category] {
        try await networkClient.request(CatalogEndpoint.categories)
    }
}
