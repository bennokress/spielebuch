//
//  Game.swift
//  Spielebuch
//
//  Created by Benno Kress on 16.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

struct Game {
    let name: String
    let groupAffiliation: GameGroup?
//    let scoreRules = ScoreRules()
    
    init(named name: String, asPartOf groupAffiliation: GameGroup? = nil) {
        self.name = name
        self.groupAffiliation = groupAffiliation
    }
}

//extension Game {
//    struct ScoreRules {
//        let instructions = "In diesem Spiel werden zunächst die Punkte aufgeschrieben. Bei Gleichstand gewinnt der Spieler mit den wenigsten Karten. Herrscht auch dann noch Gleichstand so gewinnt der Spieler mit dem meisten Geld."
//        let components = [ScoreComponent(), ScoreComponent()]
//    }
//}
//
//extension Game.ScoreRules {
//    struct ScoreComponent {
//        let sorting = ScoreSorting.ascending
//        let description = "Punkte"
//    }
//}
//
//extension Game.ScoreRules.ScoreComponent {
//    enum ScoreSorting: String {
//
//        /// Least is best.
//        case ascending = "<"
//
//        /// Most is best.
//        case descending = ">"
//
//    }
//}
