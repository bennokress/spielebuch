//
//  PlayersPresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 17.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class PlayersPresenterImplementation {
    
    private unowned var view: PlayersView
    
    init(for view: PlayersView) {
        self.view = view
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol PlayersPresenter: class {
    
    /// Populates the PlayersView with data.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func setup(with setupData: VIPViewSetupData?)
    
    /// Provides the players for the PlayersView.
    /// - Parameter playersList: The players to be displayed.
    func updateTable(with playersList: [Player])
    
    /// Instructs the PlayersView to display the details for a player.
    /// - Parameter player: The player of which the details should be displayed.
    func displayPlayerDetails(for player: Player)
    
    /// Instructs the PlayersView to display a PlayerModificationView.
    func displayAddPlayerView()
    
    /// Instructs the PlayersView to dismiss the search controller.
    func searchWasCompleted()
    
}

extension PlayersPresenterImplementation: PlayersPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.players(list) = data else { return }
        let groupedPlayers = group(players: list)
        view.updatePlayers(from: groupedPlayers)
    }
    
    func updateTable(with playersList: [Player]) {
        let groupedPlayers = group(players: playersList)
        view.updatePlayers(from: groupedPlayers)
    }
    
    func displayPlayerDetails(for player: Player) {
        let playerData = VIPViewSetupData.playerDetail(player: player)
        view.showPlayerDetailView(with: playerData)
    }
    
    func displayAddPlayerView() {
        view.showNewPlayerView()
    }
    
    func searchWasCompleted() {
        view.dismissSearchController()
    }
    
}

// MARK: - Private Helpers

extension PlayersPresenterImplementation {
    
    private func group(players: [Player]) -> [String : [Player]] {
        let sortedPlayers = players.sorted { $0.displayname.lowercased() < $1.displayname.lowercased() }
        var groupedPlayers: [String : [Player]] = [:]
        for player in sortedPlayers {
            // TODO: Allow more player names, strip whitespace and new lines, test symbols in name
            if let firstCharacter = player.displayname.first, (firstCharacter.isLetter || firstCharacter.isNumber) {
                let firstLetter = firstCharacter.uppercased()
                var playersWithTheSameFirstLetter = groupedPlayers[firstLetter] ?? []
                playersWithTheSameFirstLetter.append(player)
                groupedPlayers[firstLetter] = playersWithTheSameFirstLetter
            } else {
                log.warning("Player named \"\(player.displayname)\" was skipped.")
            }
        }
        return groupedPlayers
    }
    
}
