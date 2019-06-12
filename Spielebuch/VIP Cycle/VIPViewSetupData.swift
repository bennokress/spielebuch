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
    case gameModification(game: Game?)
    
}
