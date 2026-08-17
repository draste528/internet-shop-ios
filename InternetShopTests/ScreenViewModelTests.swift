//
//  ScreenViewModelTests.swift
//  InternetShop
//
//  Created by kair on 03.08.26.
//

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
    }

    func testLoadIsActiveWhileOperationRuns() async {
        let viewModel = BaseScreenViewModel(title: "Test")
        await viewModel.load {
            XCTAssertTrue(viewModel.isLoading)   // true during the operation
        }
        XCTAssertFalse(viewModel.isLoading)      // reset afterwards
    }

    func testLoadSuccessClearsError() async {
        let viewModel = BaseScreenViewModel(title: "Test")
        await viewModel.load { }
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadFailureSetsErrorMessage() async {
        let viewModel = BaseScreenViewModel(title: "Test")
        await viewModel.load { throw SampleError() }
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
}
