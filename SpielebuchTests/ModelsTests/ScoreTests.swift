//
//  ScoreTests.swift
//  SpielebuchTests
//
//  Created by Benno Kress on 18.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import XCTest
@testable import Spielebuch

class ScoreTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testScoreHasStartingPlayerFlag() {
        let score = Score.standard
        XCTAssert(score.isScoreOfStartingPlayer == false)
    }
    
    func testScoreHasValue() {
        let score = Score.standard
        XCTAssert(score.value == 0.0)
    }

}
