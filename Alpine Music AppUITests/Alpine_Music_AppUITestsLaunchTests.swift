//
//  Alpine_Music_AppUITestsLaunchTests.swift
//  Alpine Music AppUITests
//
//  Created by Jack Belding on 6/20/23.
//

import XCTest

final class Alpine_Music_AppUITestsLaunchTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAboutScreen() {
        app.tabBars.buttons["About"].tap()
        
        let imageView = app.images["aboutme"]
        XCTAssertTrue(imageView.exists)
        
//        let textView = app.textViews["LHK-aw-BXn"]
//        XCTAssertTrue(textView.exists)
//        XCTAssertEqual(textView.value as? String, "Alpine Music originates from Michigan State University. Jack Belding, a member of MSU's Alpine Ski and Snowboard team, dedicated Alpine Music to crafting heavyweight house and techno records with the good vibes of undergraduate life.")
//
//        let tableView = app.tables["c94-3p-Wju"]
//        XCTAssertTrue(tableView.exists)
//
//        let socialCell = tableView.cells["socialCell"]
//        XCTAssertTrue(socialCell.exists)
    }
    
    func testHomeScreen() {
        app.tabBars.buttons["Home"].tap()
        
        let streamNowLabel = app.staticTexts["Stream Now"]
        XCTAssertTrue(streamNowLabel.exists)
        
//        let tableView = app.tables["TxV-ea-AF5"]
//        XCTAssertTrue(tableView.exists)
//
//        let currentStreamCell = tableView.cells["currentStreamCell"]
//        XCTAssertTrue(currentStreamCell.exists)
//
//        let previousStreamsLabel = app.staticTexts["Previous Streams"]
//        XCTAssertTrue(previousStreamsLabel.exists)
//
//        let imageView = app.images["24D-9r-tJ5"]
//        XCTAssertTrue(imageView.exists)
    }
}
