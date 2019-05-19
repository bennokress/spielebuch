//
//  PlayerDataTests.swift
//  SpielebuchTests
//
//  Created by Benno Kress on 19.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import XCTest
@testable import Spielebuch

class PlayerDataTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testPlayerHasAFirstName() {
        let player = PlayerData.standard
        XCTAssert(player.firstName == "Benno")
    }
    
    func testPlayerHasALastName() {
        let player = PlayerData.standard
        XCTAssert(player.lastName == "Kress")
    }
    
    func testPlayerHasANickname() {
        let player = PlayerData.standard
        XCTAssert(player.nickname == nil)
    }
    
    func testPlayerHasADisplayname() {
        let player = PlayerData.standard
        XCTAssert(player.displayname == "Benno")
    }

}
