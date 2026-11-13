import Foundation

protocol APIConfiguring: Sendable {
    var scheme: String { get }
    var host: String { get }
    var port: Int? { get }
}

struct APIConfiguration: APIConfiguring {
    let scheme: String
    let host: String
    let port: Int?

    static let local = APIConfiguration(scheme: "http", host: "localhost", port: 8080)
}
