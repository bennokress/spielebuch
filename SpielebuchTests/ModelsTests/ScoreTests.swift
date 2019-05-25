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
    
    func testScoreHasAStartingPlayerFlag() {
        let score = Score.standard
        XCTAssert(score.isScoreOfStartingPlayer == Score.standardIsScoreOfStartingPlayer)
    }
    
    func testScoreHasAValue() {
        let score = Score.standard
        XCTAssert(score.value == Score.standardValue)
    }
    
    func testScoreHasTheGivenStartingPlayerFlag() {
        let givenFlag = !Score.standardIsScoreOfStartingPlayer
        
        let score1 = Score.standard
        let score2 = Score(testIsScoreOfStartingPlayer: givenFlag)
        
        XCTAssert(score1.isScoreOfStartingPlayer != givenFlag, "Score should \(Score.standardIsScoreOfStartingPlayer ? "be" : "NOT be") the one of the starting player")
        XCTAssert(score2.isScoreOfStartingPlayer == givenFlag, "Score should be \(givenFlag ? "be" : "NOT be") the one of the starting player")
    }
    
    func testScoreHasTheGivenValue() {
        let givenValue = Score.standardValue + 1
        
        let score1 = Score.standard
        let score2 = Score(testValue: givenValue)
        
        XCTAssert(score1.value != givenValue, "Score should be \(Score.standardValue), but is \(score1.value)")
        XCTAssert(score2.value == givenValue, "Score should be \(givenValue), but is \(score2.value)")
    }

}
