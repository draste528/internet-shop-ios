import XCTest
@testable import InternetShop

private struct StubHTTPClient: HTTPClient {
    let handler: @Sendable (URLRequest) async throws -> (Data, URLResponse)

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await handler(request)
    }
}

private struct SamplePayload: Codable, Equatable, Sendable {
    let id: String
    let name: String
}

private struct StubEndpoint: Endpoint {
    let path: String
    var queryItems: [URLQueryItem] = []
    var headers: [String: String] = [:]
}

final class NetworkClientTests: XCTestCase {
    private func makeResponse(statusCode: Int) throws -> HTTPURLResponse {
        let url = try XCTUnwrap(URL(string: "http://localhost:8080/test"))
        return try XCTUnwrap(HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil))
    }

    func testRequestDecodesResponseAndBuildsURL() async throws {
        let expected = SamplePayload(id: "1", name: "Sofas")
        let data = try JSONEncoder().encode(expected)
        let response = try makeResponse(statusCode: 200)

        let httpClient = StubHTTPClient { request in
            XCTAssertEqual(request.url?.absoluteString, "http://localhost:8080/api/v1/categories?limit=5")
            XCTAssertEqual(request.httpMethod, "GET")
            XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/json")
            return (data, response)
        }

        let client = NetworkClient(configuration: APIConfiguration.local, httpClient: httpClient)
        let endpoint = StubEndpoint(
            path: "/api/v1/categories",
            queryItems: [URLQueryItem(name: "limit", value: "5")],
            headers: ["Accept": "application/json"]
        )

        let result: SamplePayload = try await client.request(endpoint)
        XCTAssertEqual(result, expected)
    }

    func testRequestThrowsStatusCodeOnServerError() async throws {
        let response = try makeResponse(statusCode: 500)
        let httpClient = StubHTTPClient { _ in (Data(), response) }
        let client = NetworkClient(configuration: APIConfiguration.local, httpClient: httpClient)

        do {
            let _: SamplePayload = try await client.request(StubEndpoint(path: "/test"))
            XCTFail("Expected NetworkError.statusCode")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .statusCode(500))
        }
    }

    func testRequestThrowsDecodingFailedOnInvalidJSON() async throws {
        let response = try makeResponse(statusCode: 200)
        let httpClient = StubHTTPClient { _ in (Data("invalid".utf8), response) }
        let client = NetworkClient(configuration: APIConfiguration.local, httpClient: httpClient)

        do {
            let _: SamplePayload = try await client.request(StubEndpoint(path: "/test"))
            XCTFail("Expected NetworkError.decodingFailed")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .decodingFailed)
        }
    }

    func testRequestThrowsInvalidURLWhenHostIsEmpty() async {
        let config = APIConfiguration(scheme: "http", host: "", port:nil)
        let httpClient = StubHTTPClient { _ in (Data(), URLResponse()) }
        let client = NetworkClient(configuration: config, httpClient: httpClient)

        do {
            let _: SamplePayload = try await client.request(StubEndpoint(path: "/test"))
            XCTFail("Expected NetworkError.invalidURL")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidURL)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testRequestThrowsInvalidResponseForNonHTTPResponse() async throws {
        let url = try XCTUnwrap(URL(string: "http://localhost:8080/test"))
        let nonHTTP = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let httpClient = StubHTTPClient { _ in (Data(), nonHTTP) }
        let client = NetworkClient(configuration: APIConfiguration.local, httpClient: httpClient)

        do {
            let _: SamplePayload = try await client.request(StubEndpoint(path: "/test"))
            XCTFail("Expected NetworkError.invalidResponse")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidResponse)
        }
    }

    func testRequestWrapsTransportError() async {
        let httpClient = StubHTTPClient { _ in
            throw URLError(.cannotConnectToHost)
        }
        let client = NetworkClient(configuration: APIConfiguration.local, httpClient: httpClient)

        do {
            let _: SamplePayload = try await client.request(StubEndpoint(path: "/test"))
            XCTFail("Expected NetworkError.transportError")
        } catch let error as NetworkError {
            if case .transportError = error {
                XCTAssertTrue(true)
            } else {
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
