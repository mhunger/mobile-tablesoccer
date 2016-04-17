//
//  GameTest.swift
//  tablesoccer-mobileapp
//
//  Created by Michael Hunger on 09/04/16.
//  Copyright (c) 2016 Michael Hunger. All rights reserved.
//
import XCTest
import tablesoccermanager
import tablesoccer_mobileapp

class GameTest: XCTestCase {

    private var game = Game()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testStartGame() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
