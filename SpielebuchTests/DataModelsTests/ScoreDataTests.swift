//
//  ScoreDataTests.swift
//  SpielebuchTests
//
//  Created by Benno Kress on 18.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import XCTest
@testable import Spielebuch

class ScoreDataTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testScoreHasAPlayer() {
        let score = ScoreData.standard
        XCTAssert(score.player is PlayerData)
    }
    
    func testScoreHasStartingPlayerFlag() {
        let score = ScoreData.standard
        XCTAssert(score.isScoreOfStartingPlayer == false)
    }
    
    func testScoreHasValue() {
        let score = ScoreData.standard
        XCTAssert(score.value == 0.0)
    }

}
