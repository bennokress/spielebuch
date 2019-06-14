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
    
    init(with presenter: GamesPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol GamesInterpreter: class {
    
    /// Takes actions when the GamesView is loading.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes actions when the user searches for a game by typing in the search bar.
    /// - Parameter searchTerm: The current content of the search bar.
    func userSearches(for searchTerm: String)
    
    /// Takes actions when the user taps on a game.
    /// - Parameter game: The game the user tapped on.
    /// - Parameter isSearchActive: True if the user searched prior to tapping on the game.
    func userTapped(_ game: Game, withActiveSearch isSearchActive: Bool)
    
    /// Takes actions when the user taps the "new game" button.
    func userTappedAddGameButton()
    
    /// Takes action when a new game was added or modified.
    /// - Parameter modifiedGame: The modified game to be displayed.
    func delegateWasNotified(about modifiedGame: Game)
    
    /// Takes action when a new game was added or modified.
    func delegateWasNotifiedAboutModifiedGames()
    
}

extension GamesInterpreterImplementation: GamesInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        let gamesViewSetup = setupData ?? .games(list: gamesList)
        presenter.setup(with: gamesViewSetup)
    }
    
    // MARK: User Actions
    
    func userSearches(for searchTerm: String) {
        let filteredGamesList = searchTerm.count > 0 ? filteredGames(for: searchTerm) :  gamesList
        presenter.updateTable(with: filteredGamesList)
    }
    
    func userTapped(_ game: Game, withActiveSearch isSearchActive: Bool) {
        presenter.displayGameDetails(for: game)
        if isSearchActive {
            presenter.searchWasCompleted()
        }
    }
    
    func userTappedAddGameButton() {
        presenter.displayAddGameView()
    }
    
    // MARK: Delegate Actions
    
    func delegateWasNotified(about modifiedGame: Game) {
        presenter.updateTable(with: gamesList)
    }
    
    func delegateWasNotifiedAboutModifiedGames() {
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
