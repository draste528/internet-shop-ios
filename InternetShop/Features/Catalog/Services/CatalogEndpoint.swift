import Foundation

enum CatalogEndpoint: Endpoint {
    case categories

    var path: String {
        switch self {
        case .categories:
            return "/api/v1/categories"
        }
    }
}
