//
//  Alpine_Music_AppUITests.swift
//  Alpine Music AppUITests
//
//  Created by Jack Belding on 6/20/23.
//

import XCTest

final class Alpine_Music_AppUITests: XCTestCase {

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
