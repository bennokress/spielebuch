//
//  Player.swift
//  Spielebuch
//
//  Created by Benno Kress on 19.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

struct Player {
    let firstName: String
    let lastName: String
    let nickname: String?
    var displayname: String { return nickname ?? firstName }
    let base64Image: String?
}

extension Player: Hashable {
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(firstName)
        hasher.combine(lastName)
        hasher.combine(nickname)
        hasher.combine(base64Image)
    }
    
}
