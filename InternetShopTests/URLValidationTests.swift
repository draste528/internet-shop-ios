//
//  URLValidationTests.swift
//  InternetShop
//
//  Created by kair on 03.11.26.
//

import XCTest
@testable import InternetShop

final class URLValidationTests: XCTestCase {

    func testRemoteLinksAccepted() {
        XCTAssertEqual(URL(validatedString: "https://example.com/1.jpg")?.absoluteString, "https://example.com/1.jpg")
        XCTAssertEqual(URL(validatedString: "http://example.com/1.jpg")?.absoluteString, "http://example.com/1.jpg")
    }

    func testSurroundingWhitespaceIsTrimmed() {
        XCTAssertEqual(URL(validatedString: "  https://example.com/1.jpg \n")?.absoluteString, "https://example.com/1.jpg")
    }

    func testFileURLAccepted() {
        let url = URL(validatedString: "file:///tmp/photo.jpg")
        XCTAssertEqual(url?.isFileURL, true)
        XCTAssertEqual(url?.path(), "/tmp/photo.jpg")
    }

    func testAbsolutePathBecomesFileURL() {
        let url = URL(validatedString: "/tmp/photo.jpg")
        XCTAssertEqual(url?.isFileURL, true)
        XCTAssertEqual(url?.path(), "/tmp/photo.jpg")
    }

    func testInvalidStringsRejected() {
        let invalid = ["", "   ", "not a link", "photo.jpg", "http://", "httpfoo", "ftp://example.com/1.jpg", "mailto:a@b.com"]
        for string in invalid {
            XCTAssertNil(URL(validatedString: string), "Expected nil for \"\(string)\"")
        }
    }

    func testCustomAllowedSchemes() {
        XCTAssertNotNil(URL(validatedString: "ftp://example.com/1.jpg", allowedSchemes: ["ftp"]))
        XCTAssertNil(URL(validatedString: "/tmp/photo.jpg", allowedSchemes: ["https"]))
        XCTAssertNil(URL(validatedString: "https://example.com/1.jpg", allowedSchemes: ["file"]))
    }
}
