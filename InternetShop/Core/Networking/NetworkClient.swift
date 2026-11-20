import Foundation

protocol NetworkClientProtocol: Sendable {
    func request<T: Decodable & Sendable>(_ endpoint: any Endpoint) async throws -> T
}

struct NetworkClient: NetworkClientProtocol {
    private let configuration: any APIConfiguring
    private let httpClient: any HTTPClient
    private let makeDecoder: @Sendable () -> JSONDecoder

    init(
        configuration: any APIConfiguring = APIConfiguration.local,
        httpClient: any HTTPClient = URLSession.shared,
        makeDecoder: @escaping @Sendable () -> JSONDecoder = { JSONDecoder() }
    ) {
        self.configuration = configuration
        self.httpClient = httpClient
        self.makeDecoder = makeDecoder
    }

    func request<T: Decodable & Sendable>(_ endpoint: any Endpoint) async throws -> T {
        let urlRequest = try makeRequest(for: endpoint)

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await httpClient.data(for: urlRequest)
        } catch {
            throw NetworkError.transportError(error.localizedDescription)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCode(httpResponse.statusCode)
        }

        do {
            return try makeDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }

    private func makeRequest(for endpoint: any Endpoint) throws -> URLRequest {
        guard !configuration.host.isEmpty else {
            throw NetworkError.invalidURL
        }

        var components = URLComponents()
        components.scheme = configuration.scheme
        components.host = configuration.host
        components.port = configuration.port
        components.path = endpoint.path
        if !endpoint.queryItems.isEmpty {
            components.queryItems = endpoint.queryItems
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        for (key, value) in endpoint.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
