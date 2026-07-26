//
//  AppColorTests.swift
//  InternetShop
//
//  Created by kair on 26.07.26.
//

import XCTest
import SwiftUI
@testable import InternetShop

final class AppColorTests: XCTestCase {

    // MARK: - Brand Colors
    func testAppPrimaryColor() {
        XCTAssertEqual(Color.appPrimary, Color(red: 162/255, green: 189/255, blue: 128/255))
    }

    func testAppDarkGreenColor() {
        XCTAssertEqual(Color.appDarkGreen, Color(red: 128/255, green: 151/255, blue: 97/255))
    }

    // MARK: - Accent Colors
    func testAppGreenColor() {
        XCTAssertEqual(Color.appGreen, Color(red: 52/255, green: 199/255, blue: 89/255))
    }

    func testAppYellowColor() {
        XCTAssertEqual(Color.appYellow, Color(red: 233/255, green: 202/255, blue: 93/255))
    }

    func testAppRedColor() {
        XCTAssertEqual(Color.appRed, Color(red: 255/255, green: 59/255, blue: 48/255))
    }

    // MARK: - Neutral Colors
    func testAppGrayColor() {
        XCTAssertEqual(Color.appGray, Color(red: 153/255, green: 153/255, blue: 153/255))
    }

    func testAppLightGrayColor() {
        XCTAssertEqual(Color.appLightGray, Color(red: 229/255, green: 229/255, blue: 229/255))
    }

    func testAppDisabledColor() {
        XCTAssertEqual(Color.appDisabled, Color(red: 237/255, green: 237/255, blue: 237/255))
    }

    // MARK: - Base Colors
    func testAppBlackColor() {
        XCTAssertEqual(Color.appBlack, Color.black)
    }

    func testAppWhiteColor() {
        XCTAssertEqual(Color.appWhite, Color.white)
    }
}
