//
//  GameGroupTests.swift
//  SpielebuchTests
//
//  Created by Benno Kress on 22.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import XCTest
@testable import Spielebuch

class GameGroupTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testGameGroupHasAName() {
        let gameGroup = GameGroup.standard
        XCTAssert(gameGroup.name == GameGroup.standardName)
    }
    
    func testGameGroupHasTheGivenName() {
        let givenName = "Not \(GameGroup.standardName)"
        
        let gameGroup1 = GameGroup.standard
        let gameGroup2 = GameGroup(testName: givenName)
        
        XCTAssert(gameGroup1.name != givenName, "Name should be \(GameGroup.standardName.inQuotes), but is \(gameGroup1.name.inQuotes)")
        XCTAssert(gameGroup2.name == givenName, "Name should be \(givenName.inQuotes), but is \(gameGroup2.name.inQuotes)")
    }

}
