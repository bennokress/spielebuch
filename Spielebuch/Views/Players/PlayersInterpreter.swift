//
//  PlayersInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 17.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class PlayersInterpreterImplementation {
    
    private let presenter: PlayersPresenter
    
    init(with presenter: PlayersPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol PlayersInterpreter: class {
    
    /// Takes actions when the PlayersView is loading.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes actions when the user searches for a player by typing in the search bar.
    /// - Parameter searchTerm: The current content of the search bar.
    func userSearches(for searchTerm: String)
    
    /// Takes actions when the user taps on a player.
    /// - Parameter player: The player the user tapped on.
    /// - Parameter isSearchActive: True if the user searched prior to tapping on the player.
    func userTapped(_ player: Player, withActiveSearch isSearchActive: Bool)
    
    /// Takes actions when the user taps the "new player" button.
    func userTappedAddPlayerButton()
    
    /// Takes action when a new player was added or modified.
    /// - Parameter modifiedPlayer: The modified player to be displayed.
    func delegateWasNotified(about modifiedPlayer: Player)
    
    /// Takes action when a new player was added or modified.
    func delegateWasNotifiedAboutModifiedPlayers()
    
}

extension PlayersInterpreterImplementation: PlayersInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        let playersViewSetup = setupData ?? VIPViewSetupData.players(list: playersList)
        presenter.setup(with: playersViewSetup)
    }
    
    // MARK: User Actions
    
    func userSearches(for searchTerm: String) {
        let filteredPlayersList = searchTerm.count > 0 ? filteredPlayers(for: searchTerm) :  playersList
        presenter.updateTable(with: filteredPlayersList)
    }
    
    func userTapped(_ player: Player, withActiveSearch isSearchActive: Bool) {
        presenter.displayPlayerDetails(for: player)
        if isSearchActive {
            presenter.searchWasCompleted()
        }
    }
    
    func userTappedAddPlayerButton() {
        presenter.displayAddPlayerView()
    }
    
    // MARK: Delegate Actions
    
    func delegateWasNotified(about modifiedPlayer: Player) {
        presenter.updateTable(with: playersList)
    }
    
    func delegateWasNotifiedAboutModifiedPlayers() {
        presenter.updateTable(with: playersList)
    }
    
}

// MARK: - Private Helpers

extension PlayersInterpreterImplementation {
    
    private var playersList: [Player] {
        return Mock.shared.players
    }
    
    private func filteredPlayers(for searchTerm: String) -> [Player] {
        return playersList.filter { $0.displayname.lowercased().contains(searchTerm.lowercased()) }
    }
    
}
