//
//  DataModels+Defaults.swift
//  SpielebuchTests
//
//  Created by Benno Kress on 16.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation
@testable import Spielebuch

extension Game {
    static let standardName = "Standard Game"
    
    static let standard = Game()
    init(testName name: String = standardName) {
        self = Game(name: name)
    }
}

extension Match {
    static let standardDate = Date(timeIntervalSince1970: 607876860) // = 06.04.1989, 16:41
    static let standardScores = [Score.standard, Score(testPlayer: Player.standard, testIsScoreOfStartingPlayer: true, testValue: 85.0)]
    
    static let standard = Match()
    init(testDate date: Date = standardDate, testGame game: Game = Game.standard, testScores scores: [Score] = standardScores) {
        self = Match(date: date, game: game, scores: scores)
    }
}

extension Player {
    static let standardFirstName = "Standard First Name"
    static let standardLastName = "Standard Last Name"
    static let standardNickname = "Standard Nickname"
    static let standardBase64Image = Base64Image.dummy
    
    static let standard = Player(firstName: standardFirstName, lastName: standardLastName, nickname: standardNickname, base64Image: standardBase64Image)
    init(testFirstName firstName: String = standardFirstName, testLastName lastName: String = standardLastName, testNickname nickname: String? = standardNickname, testBase64Image base64Image: String? = standardBase64Image) {
        self = Player(firstName: firstName, lastName: lastName, nickname: nickname, base64Image: base64Image)
    }
}

extension Score {
    static let standardIsScoreOfStartingPlayer = false
    static let standardValue = 89.4
    
    static let standard = Score()
    init(testPlayer player: Player = Player.standard, testIsScoreOfStartingPlayer isScoreOfStartingPlayer: Bool = standardIsScoreOfStartingPlayer, testValue value: Double = standardValue) {
        self = Score(player: player, isScoreOfStartingPlayer: isScoreOfStartingPlayer, value: value)
    }
}
