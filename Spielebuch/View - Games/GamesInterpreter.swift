//
//  GamesInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 29.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class GamesInterpreterImplementation {
    
    private let presenter: GamesPresenter
    
    /// This initializer is called when a new GamesView is created.
    init(with presenter: GamesPresenter) {
        self.presenter = presenter
    }
    
    private func getGamesList() -> [Game] {
        return Mock.games
    }
    
}

// MARK: - GamesInterpreter Protocol
protocol GamesInterpreter: class {
    
    /// Takes the necessary actions when the GamesView is finished loading
    func viewWillAppear(with setupData: VIPViewSetupData?)
    
}

// MARK: - GamesInterpreter Conformance
extension GamesInterpreterImplementation: GamesInterpreter {
    
    func viewWillAppear(with setupData: VIPViewSetupData?) {
        let gamesViewSetup = setupData ?? .games(list: getGamesList())
        presenter.setup(with: gamesViewSetup)
    }
    
}
