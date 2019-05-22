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
        XCTAssert(player.firstName == Player.standardFirstName)
    }
    
    func testPlayerHasALastName() {
        let player = Player.standard
        XCTAssert(player.lastName == Player.standardLastName)
    }
    
    func testPlayerHasANickname() {
        let player = Player.standard
        XCTAssert(player.nickname == Player.standardNickname)
    }
    
    func testPlayerHasADisplayname() {
        let player = Player.standard
        XCTAssert(player.displayname == Player.standardNickname)
    }
    
    func testPlayerAnEncodedImage() {
        let player = Player.standard
        XCTAssert(player.base64Image == Player.standardBase64Image)
    }
    
    func testPlayerHasTheGivenFirstName() {
        let givenName = "Not \(Player.standardFirstName)"
        
        let player1 = Player.standard
        let player2 = Player(testFirstName: givenName)
        
        XCTAssert(player1.firstName != givenName, "Name should be \(Player.standardFirstName.inQuotes), but is \(player1.firstName.inQuotes)")
        XCTAssert(player2.firstName == givenName, "Name should be \(givenName.inQuotes), but is \(player2.firstName.inQuotes)")
    }
    
    func testPlayerHasTheGivenLastName() {
        let givenName = "Not \(Player.standardLastName)"
        
        let player1 = Player.standard
        let player2 = Player(testLastName: givenName)
        
        XCTAssert(player1.lastName != givenName, "Name should be \(Player.standardLastName.inQuotes), but is \(player1.lastName.inQuotes)")
        XCTAssert(player2.lastName == givenName, "Name should be \(givenName.inQuotes), but is \(player2.lastName.inQuotes)")
    }
    
    func testPlayerHasTheGivenNickname() {
        let givenName = "Not \(Player.standardNickname)"
        
        let player1 = Player.standard
        let player2 = Player(testNickname: givenName)
        
        XCTAssert(player1.nickname != givenName, "Name should be \(Player.standardNickname.inQuotes), but is \(player1.nickname?.inQuotes ?? "not set")")
        XCTAssert(player2.nickname == givenName, "Name should be \(givenName.inQuotes), but is \(player2.nickname?.inQuotes ?? "not set")")
    }
    
    func testPlayerHasNicknameAsDisplaynameIfAvailableAndFirstNameOtherwise() {
        let nickname = "Nickname"
        
        let player1 = Player(testNickname: nickname)
        let player2 = Player(testNickname: nil)
        
        XCTAssert(player1.displayname == nickname, "Name should be \(nickname.inQuotes), but is \(player1.displayname.inQuotes)")
        XCTAssert(player2.displayname == Player.standardFirstName, "Name should be \(Player.standardFirstName.inQuotes), but is \(player2.displayname.inQuotes)")
    }
    
    func testPlayerHasTheGivenBase64Image() {
        let givenBase64Image = "Not \(Player.standardNickname)"
        let emptyBase64Image: String? = nil
        
        let player1 = Player.standard
        let player2 = Player(testBase64Image: givenBase64Image)
        let player3 = Player(testBase64Image: emptyBase64Image)
        
        XCTAssert(player1.base64Image != givenBase64Image)
        XCTAssert(player1.base64Image != emptyBase64Image)
        XCTAssert(player2.base64Image == givenBase64Image)
        XCTAssert(player3.base64Image == emptyBase64Image)
    }

}
