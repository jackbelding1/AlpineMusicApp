//
//  AboutScreenUITests.swift
//  Alpine Music AppUITests
//
//  Created by Jack Belding on 6/20/23.
//

import XCTest

final class AboutScreenUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        print(app.debugDescription)
    }

    func testAboutScreen() {
        app.tabBars.buttons["About"].tap()

        let imageView = app.images["aboutme"]
        XCTAssertTrue(imageView.exists)

        let textView = app.textViews["aboutTextView"]
        XCTAssertTrue(textView.exists)
        XCTAssertEqual(textView.value as? String, "Alpine Music originates from Michigan State University. Jack Belding, a member of MSU's Alpine Ski and Snowboard team, dedicated Alpine Music to crafting heavyweight house and techno records with the good vibes of undergraduate life.")

        let tableView = app.tables["socialTable"]
        XCTAssertTrue(tableView.exists)

        let socialCell = tableView.cells["socialCell"]
        XCTAssertTrue(socialCell.exists)
        print(socialCell.images)
    }
}
