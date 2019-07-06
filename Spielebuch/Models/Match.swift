//
//  Match.swift
//  Spielebuch
//
//  Created by Benno Kress on 18.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

struct Match {
    let date: Date
    let game: Game
    let scores: [Score]
}

extension Match {
    
    static func initIfPossible(date: Date?, game: Game?, scores: [Score]?) -> Match? {
        guard let date = date, let game = game, let scores = scores, scores.count > 0 else { return nil }
        return Match(date: date, game: game, scores: scores)
    }
    
}

extension Match: Hashable {
    
    static func == (lhs: Match, rhs: Match) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(game)
        hasher.combine(scores)
    }
    
}
