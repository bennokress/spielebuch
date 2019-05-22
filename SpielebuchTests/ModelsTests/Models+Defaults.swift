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
    
    static let standard = Match()
    init(testGame game: Game = Game.standard) {
        self = Match(game: game)
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
    
    static let standard = Score(player: Player.standard)
    init(testPlayer player: Player = Player.standard) {
        self = Score(player: player)
    }
}
