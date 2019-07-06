//
//  Score.swift
//  Spielebuch
//
//  Created by Benno Kress on 18.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

struct Score {
    let player: Player
    let isScoreOfStartingPlayer: Bool
    let value: Double
}

extension Score: Hashable {
    
    static func == (lhs: Score, rhs: Score) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(player)
        hasher.combine(isScoreOfStartingPlayer)
        hasher.combine(value)
    }
    
}
