//
//  Mock.swift
//  Spielebuch
//
//  Created by Benno Kress on 29.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

// THIS IS ONLY A TEMPORARY SOLUTION TO GET THE UI READY FOR REAL DATA //

struct Mock {
    
    static var games: [Game] {
        let azul = Game(named: "Azul")
        let istanbul = Game(named: "Istanbul")
        let carcassonne = Game(named: "Carcassonne")
        return [azul, istanbul, carcassonne]
    }
    
}
