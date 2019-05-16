//
//  GameData.swift
//  Spielebuch
//
//  Created by Benno Kress on 16.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

struct GameData {
    let name = "Name of the Game"
    let primaryHTMLColor = "#000000"
    let secondaryHTMLColor = "#FFFFFF"
    let scoreModelName = "simpleDescending" // see NOTE #1
    
    // NOTE #1
    // --> scoreModelName gets converted to ScoreModel later
    // ScoreModel contains:
    //  * scoreComponentDescriptions --> e.g. ["Points", "Coins", "Cards"]
    //  * scoreComponentSorting --> e.g. [.descending, .descending, .ascending]
    //  * scoreComponentInstruction --> short info text for the user to be displayed on tap
}
