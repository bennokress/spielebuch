//
//  VIPViewSetupData.swift
//  Spielebuch
//
//  Created by Benno Kress on 25.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

enum VIPViewSetupData {
    
    case games(list: [Game])
    case gameDetail(game: Game)
    case gameModification(game: Game?) // 2 Use Cases: Edit (game is set) and New (game is nil)
    case matches(list: [Match])
    case matchDetail(match: Match)
    case matchModification(match: Match?) // 2 Use Cases: Edit (match is set) and New (match is nil)
    case players(list: [Player])
    case playerDetail(player: Player)
    case playerModification(player: Player?) // 2 Use Cases: Edit (player is set) and New (player is nil)
    
    func setup(destinationViewController: VIPViewController) {
        destinationViewController.setup(with: self)
    }
    
}
