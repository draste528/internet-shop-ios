import Foundation

enum NetworkError: Error, Equatable, Sendable, LocalizedError {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decodingFailed
    case transportError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .statusCode(let code):
            return "Server returned status code \(code)."
        case .decodingFailed:
            return "Failed to decode server response."
        case .transportError(let message):
            return message
        }
    }
}
