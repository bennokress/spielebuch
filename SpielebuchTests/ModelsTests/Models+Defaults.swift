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
    static let standard = Game(name: standardName)
}

extension Match {
    static let standard = Match(game: Game.standard)
}

extension Player {
    static let standard = Player()
}

extension Score {
    static let standard = Score()
}
