//
//  GameTests.swift
//  SpielebuchTests
//
//  Created by Benno Kress on 16.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import XCTest
@testable import Spielebuch

class GameTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testGameHasAName() {
        let game = Game.standard
        XCTAssert(game.name == Game.standardName)
    }
    
    func testGameHasTheGivenName() {
        let givenName = "Not \(Game.standardName)"
        
        let game1 = Game.standard
        let game2 = Game(testName: givenName)
        
        XCTAssert(game1.name != givenName, "Name should be \(Game.standardName.inQuotes), but is \(game1.name.inQuotes)")
        XCTAssert(game2.name == givenName, "Name should be \(givenName.inQuotes), but is \(game2.name.inQuotes)")
    }

}
