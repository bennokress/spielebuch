//
//  Match.swift
//  Spielebuch
//
//  Created by Benno Kress on 18.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

struct Match {
    let date = Date(timeIntervalSince1970: 607876860)
    let game = Game()
    let scores: [Score] = []
}
