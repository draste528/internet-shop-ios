import XCTest
@testable import InternetShop

@MainActor
final class ScreenViewModelTests: XCTestCase {

    private struct SampleError: Error {}

    func testBaseScreenViewModelStoresTitle() {
        let viewModel = BaseScreenViewModel(title: "Test")
        XCTAssertEqual(viewModel.title, "Test")
    }

    func testInitialLoadingStateIsIdle() {
        let viewModel = BaseScreenViewModel(title: "Test")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isShowingError)
    }

    func testLoadIsActiveWhileOperationRuns() async throws {
        let viewModel = BaseScreenViewModel(title: "Test")
        try await viewModel.load {
            XCTAssertTrue(viewModel.isLoading)
        }
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadSuccessClearsError() async throws {
        let viewModel = BaseScreenViewModel(title: "Test")
        viewModel.errorMessage = "Previous error"
        try await viewModel.load { }
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadFailureRethrowsAndResetsLoading() async {
        let viewModel = BaseScreenViewModel(title: "Test")
        do {
            try await viewModel.load { throw SampleError() }
            XCTFail("Expected load to rethrow")
        } catch {
            XCTAssertTrue(error is SampleError)
        }
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testDismissingErrorClearsErrorMessage() {
        let viewModel = BaseScreenViewModel(title: "Test")
        viewModel.errorMessage = "Network failed"
        XCTAssertTrue(viewModel.isShowingError)
        viewModel.isShowingError = false
        XCTAssertNil(viewModel.errorMessage)
    }
}
