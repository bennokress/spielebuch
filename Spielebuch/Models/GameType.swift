//
//  GameType.swift
//  Spielebuch
//
//  Created by Benno Kress on 19.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

enum GameType {
    case baseGame
    indirect case ruleset(of: Game)
    indirect case `extension`(for: Game)
}
