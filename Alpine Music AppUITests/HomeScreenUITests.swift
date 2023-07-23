//
//  HomeScreenUITests.swift
//  Alpine Music AppUITests
//
//  Created by Jack Belding on 6/20/23.
//

import XCTest

final class HomeScreenUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        print(app.debugDescription)
    }

    func testHomeScreen() {
        app.tabBars.buttons["Home"].tap()

        let streamNowLabel = app.staticTexts["Stream Now"]
        XCTAssertTrue(streamNowLabel.exists)

        let tableView = app.tables["streamView"]
        XCTAssertTrue(tableView.exists)

        let currentStreamCell = tableView.cells["currentStreamCell"]
        XCTAssertTrue(currentStreamCell.exists)

        let previousStreamsLabel = app.staticTexts["Previous Streams"]
        XCTAssertTrue(previousStreamsLabel.exists)

        let imageView = app.images["afk"]
        XCTAssertTrue(imageView.exists)
    }
}
