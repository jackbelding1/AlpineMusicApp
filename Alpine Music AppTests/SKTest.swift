//
//  SKTest.swift
//  Alpine Music AppTests
//
//  Created by Jack Belding on 6/30/23.
//

import XCTest
import StoreKit
import StoreKitTest

final class SKTest: XCTestCase {
    
    let productIDs = [
        "tier.0",
        "tier.1",
        "tier.2",
        "tier.3",
        "tier.4",
        "tier.5"
    ]
    
    override func setUp() {
        super.setUp()
    }

    
    func testLoadProducts() async throws {
        let session = try SKTestSession(configurationFileNamed: "product")

        // get products response
        let response = try await Product.products(for: productIDs)
        let products = try XCTUnwrap(response)
        XCTAssertNotNil(products, "Products should not be nil")
        XCTAssertEqual(products.count, 6, "Incorrect number of products")
    }
    
    func testPurchase() async throws {
        let session = try SKTestSession(configurationFileNamed: "product")
        session.clearTransactions()
        session.disableDialogs = true
        session.askToBuyEnabled = true

        XCTAssertNoThrow(try session.buyProduct(productIdentifier: "tier.0"))
        
        XCTAssertTrue(session.allTransactions().count == 1)
        XCTAssertTrue(session.allTransactions()[0].state == .deferred)
        
        XCTAssertNoThrow(try session.approveAskToBuyTransaction(identifier: session.allTransactions()[0].identifier))
    }

}
