//
//  intuitCraftDemoUITests.swift
//  intuitCraftDemoUITests
//
//  Created by Brian Schick on 3/5/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import XCTest

class intuitCraftDemoUITests: XCTestCase {
	
	/*
	Please note:
	
	I didn't have time to implement UI Tests for this demo. Happy to do this during interactive sessions of helpful :)
	*/

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
    }

    func testExample() {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
