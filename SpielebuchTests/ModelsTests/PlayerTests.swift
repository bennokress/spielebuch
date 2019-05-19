//
//  PlayerTests.swift
//  SpielebuchTests
//
//  Created by Benno Kress on 19.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import XCTest
@testable import Spielebuch

class PlayerTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testPlayerHasAFirstName() {
        let player = Player.standard
        XCTAssert(player.firstName == "Benno")
    }
    
    func testPlayerHasALastName() {
        let player = Player.standard
        XCTAssert(player.lastName == "Kress")
    }
    
    func testPlayerHasANickname() {
        let player = Player.standard
        XCTAssert(player.nickname == nil)
    }
    
    func testPlayerHasADisplayname() {
        let player = Player.standard
        XCTAssert(player.displayname == "Benno")
    }
    
    func testPlayerAnEncodedImage() {
        let player = Player.standard
        XCTAssert(player.base64Image == "")
    }

}