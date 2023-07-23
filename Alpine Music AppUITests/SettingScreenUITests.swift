//
//  SettingScreenUITests.swift
//  Alpine Music AppUITests
//
//  Created by Jack Belding on 6/20/23.
//

import XCTest

final class SettingScreenUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        print(app.debugDescription)
    }

    func testSettingScreen() {
        app.tabBars.buttons["Settings"].tap()
        print(app.debugDescription)

        let tableView = app.tables["settingsTable"]
        XCTAssertTrue(tableView.exists)

        let settingsCell = tableView.cells["settingsCell"]
        XCTAssertTrue(settingsCell.exists)

        let supportMeCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(supportMeCell.exists)

        supportMeCell.tap()

        let supportTV = app.textViews["supportTV"]
        XCTAssertTrue(supportTV.exists)

        let disclaimerTV = app.textViews["disclaimerTV"]
        XCTAssertTrue(disclaimerTV.exists)

        // Test donation options

        // test privacy policy
        let supportMeBackButton = app.buttons["supportMeBackButton"]
        XCTAssertTrue(supportMeBackButton.exists)

        supportMeBackButton.tap()

        let privacyPolicyCell = tableView.cells.element(boundBy: 1)
        XCTAssertTrue(privacyPolicyCell.exists)

        privacyPolicyCell.tap()
        let privacyPolicyWebView = app.webViews["privacyPolicyWebView"]
        XCTAssertTrue(privacyPolicyWebView.exists)


    }
}
