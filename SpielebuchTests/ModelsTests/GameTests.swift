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
        XCTAssert(game.name == "Name of the Game")
    }
    
    func testGameHasAPrimaryColor() {
        let game = Game.standard
        XCTAssert(game.primaryHTMLColor == "#000000")
    }
    
    func testGameHasASecondaryColor() {
        let game = Game.standard
        XCTAssert(game.secondaryHTMLColor == "#FFFFFF")
    }
    
    func testGameHasAScoreModel() {
        let game = Game.standard
        XCTAssert(game.scoreModelName == "simpleDescending")
    }
    
    func testGameHasAnEncodedImage() {
        let game = Game.standard
        XCTAssert(game.base64Image == "")
    }

}
