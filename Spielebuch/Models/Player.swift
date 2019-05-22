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
