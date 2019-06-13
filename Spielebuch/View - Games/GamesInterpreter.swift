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
    
    /// Takes the necessary actions when the GamesView is loading
    func loadView(with setupData: VIPViewSetupData?)
    
    /// Takes the necessary actions when a GameModificationView notifies about changes
    func gameChanged(to modifiedGame: Game)
    
    /// Takes the necessary actions when a GameModificationView notifies about changes
    func gamesWereModified()
    
    /// Retrieves a filtered list of games based on the search term
    func userSearches(for searchTerm: String)
    
    /// Passes the game on to the Game Detail View and opens it
    func userTapped(_ game: Game)
    
    /// Passes the game on to the Game Detail View and opens it
    func userTappedSearched(_ game: Game)
    
    /// Prepares to show the New Game View
    func userTappedAddGameButton()
    
}

extension GamesInterpreterImplementation: GamesInterpreter {
    
    // MARK: View Actions
    
    func loadView(with setupData: VIPViewSetupData?) {
        let gamesViewSetup = setupData ?? .games(list: gamesList)
        presenter.setup(with: gamesViewSetup)
    }
    
    // MARK: User Actions
    
    func userSearches(for searchTerm: String) {
        let filteredGamesList = searchTerm.count > 0 ? filteredGames(for: searchTerm) :  gamesList
        presenter.updateTable(with: filteredGamesList)
    }
    
    func userTapped(_ game: Game) {
        presenter.displayGameDetails(for: game)
    }
    
    func userTappedSearched(_ game: Game) {
        presenter.displayGameDetails(for: game)
        presenter.searchWasCompleted()
    }
    
    func userTappedAddGameButton() {
        presenter.displayAddGameView()
    }
    
    // MARK: Delegate Actions
    
    func gameChanged(to modifiedGame: Game) {
        presenter.updateTable(with: gamesList)
    }
    
    func gamesWereModified() {
        presenter.updateTable(with: gamesList)
    }
    
}

// MARK: - Private Helpers
extension GamesInterpreterImplementation {
    
    private var gamesList: [Game] {
        return Mock.shared.games
    }
    
    private func filteredGames(for searchTerm: String) -> [Game] {
        return gamesList.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
}
