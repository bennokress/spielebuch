//
//  MatchTests.swift
//  SpielebuchTests
//
//  Created by Benno Kress on 18.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import XCTest
@testable import Spielebuch

class MatchTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testMatchHasADate() {
        let match = Match.standard
        XCTAssert(match.date == Match.standardDate)
    }
    
    func testMatchHasScores() {
        let match = Match.standard
        XCTAssert(match.scores.count == Match.standardScores.count)
    }
    
    func testMatchHasTheGivenDate() {
        let givenDate = Match.standardDate.addingTimeInterval(60)
        
        let match1 = Match.standard
        let match2 = Match(testDate: givenDate)
        
        XCTAssert(match1.date != givenDate, "Match date should be \(Match.standardDate), but is \(match1.date)")
        XCTAssert(match2.date == givenDate, "Match date should be \(givenDate), but is \(match2.date)")
    }
    
    func testMatchHasTheGivenScores() {
        // TODO: Test of actual scores equality is better with Score conforming to Equatable protocol
        let givenScores = (Match.standardScores.count > 1) ? [Match.standardScores.first!] : [Score(), Score(testValue: 91.0)]
        
        let match1 = Match.standard
        let match2 = Match(testScores: givenScores)
        
        XCTAssert(match1.scores.count != givenScores.count, "Match should have \(Match.standardScores.count) scores, but has \(match1.scores.count)")
        XCTAssert(match2.scores.count == givenScores.count, "Match should have \(givenScores.count)scores, but has \(match2.scores.count)")
    }

}
