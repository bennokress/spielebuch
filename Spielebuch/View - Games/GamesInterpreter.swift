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
    
}

// MARK: - Public Methods
protocol GamesInterpreter: class {
    
    /// Takes the necessary actions when the GamesView is finished loading
    func viewWillAppear(with setupData: VIPViewSetupData?)
    
    /// Retrieves a filtered list of games based on the search term
    func userSearches(for searchTerm: String)
    
    /// Passes the game on to the Game Detail View and opens it
    func userTappedCell(of game: Game)
    
    /// Prepares to show the New Game View
    func userTappedAddGameButton()
    
}

extension GamesInterpreterImplementation: GamesInterpreter {
    
    // MARK: View Actions
    
    func viewWillAppear(with setupData: VIPViewSetupData?) {
        let gamesViewSetup = setupData ?? .games(list: gamesList)
        presenter.setup(with: gamesViewSetup)
    }
    
    // MARK: User Actions
    
    func userSearches(for searchTerm: String) {
        let filteredGamesList = searchTerm.count > 0 ? filteredGames(for: searchTerm) :  gamesList
        presenter.updateTable(with: filteredGamesList)
    }
    
    func userTappedCell(of game: Game) {
        presenter.displayGameDetails(for: game)
    }
    
    func userTappedAddGameButton() {
        presenter.displayAddGameView()
    }
    
}

// MARK: - Private Helpers
extension GamesInterpreterImplementation {
    
    private var gamesList: [Game] {
        return Mock.games
    }
    
    private func filteredGames(for searchTerm: String) -> [Game] {
        log.verbose("Searching for \"\(searchTerm)\"")
        return gamesList.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
}
