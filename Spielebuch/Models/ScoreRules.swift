//
//  ScoreRules.swift
//  Spielebuch
//
//  Created by Benno Kress on 19.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

extension Game {
    struct ScoreRules {
    }
}

extension Game.ScoreRules {
    struct ScoreComponent {
    }
}

extension Game.ScoreRules.ScoreComponent {
    enum ScoreSorting: String {
        
        /// Least is best.
        case ascending = "<"
        
        /// Most is best.
        case descending = ">"
        
    }
}
