//
//  GameDataTests.swift
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
        let game = Defaults.game
        XCTAssert(game.name == "Name of the Game")
    }

}
