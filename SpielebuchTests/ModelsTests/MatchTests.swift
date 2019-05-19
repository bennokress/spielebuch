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
        XCTAssert(match.date == Date(timeIntervalSince1970: 607876860)) // 06.04.1989, 16:41
    }
    
    func testMatchHasAGame() {
        let match = Match.standard
        XCTAssert(match.game is Game)
    }
    
    func testMatchHasScores() {
        let match = Match.standard
        XCTAssert(match.scores.isEmpty)
    }

}
