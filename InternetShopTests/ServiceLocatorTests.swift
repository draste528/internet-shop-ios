import XCTest
@testable import InternetShop

private protocol DummyService: Sendable {
    var value: Int { get }
}

private struct DummyServiceImpl: DummyService {
    let value: Int
}

final class ServiceLocatorTests: XCTestCase {
    func testRegisterAndResolveProtocol() {
        let locator = ServiceLocator()
        let service: any DummyService = DummyServiceImpl(value: 42)
        locator.register(service, for: (any DummyService).self)

        let resolved = locator.resolve((any DummyService).self)
        XCTAssertEqual(resolved?.value, 42)
    }

    func testResolveUnregisteredReturnsNil() {
        let locator = ServiceLocator()
        let resolved = locator.resolve((any DummyService).self)
        XCTAssertNil(resolved)
    }

    func testRegisterOverwritesPreviousInstance() {
        let locator = ServiceLocator()
        locator.register(DummyServiceImpl(value: 1) as any DummyService, for: (any DummyService).self)
        locator.register(DummyServiceImpl(value: 2) as any DummyService, for: (any DummyService).self)

        let resolved = locator.resolve((any DummyService).self)
        XCTAssertEqual(resolved?.value, 2)
    }
}
