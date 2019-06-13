//
//  GamesPresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 29.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class GamesPresenterImplementation {
    
    private unowned var view: GamesView
    
    init(for view: GamesView) {
        self.view = view
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol GamesPresenter: class {
    
    /// Populates the GamesView with data.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func setup(with setupData: VIPViewSetupData?)
    
    /// Provides the games for the GamesView.
    /// - Parameter gamesList: The games to be displayed.
    func updateTable(with gamesList: [Game])
    
    /// Instructs the GamesView to display the details for a game.
    /// - Parameter game: The game of which the details should be displayed.
    func displayGameDetails(for game: Game)
    
    /// Instructs the GamesView to display a GameModificationView.
    func displayAddGameView()
    
    /// Instructs the GamesView to dismiss the search controller.
    func searchWasCompleted()
    
}

// MARK: - GamesPresenter Conformance
extension GamesPresenterImplementation: GamesPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.games(list) = data else { return }
        let groupedGames = group(games: list)
        view.updateGames(from: groupedGames)
    }
    
    func updateTable(with gamesList: [Game]) {
        let groupedGames = group(games: gamesList)
        view.updateGames(from: groupedGames)
    }
    
    func displayGameDetails(for game: Game) {
        let gameData = VIPViewSetupData.gameDetail(game: game)
        view.showGameDetails(with: gameData)
    }
    
    func displayAddGameView() {
        view.showNewGameView()
    }
    
    func searchWasCompleted() {
        view.dismissSearchController()
    }
    
}

// MARK: - Private Helpers

extension GamesPresenterImplementation {
    
    private func group(games: [Game]) -> [String : [Game]] {
        let sortedGames = games.sorted { $0.name.lowercased() < $1.name.lowercased() }
        var groupedGames: [String : [Game]] = [:]
        for game in sortedGames {
            // TODO: Allow more game names, strip whitespace and new lines, test symbols in name
            if let firstCharacter = game.name.first, (firstCharacter.isLetter || firstCharacter.isNumber) {
                let firstLetter = firstCharacter.uppercased()
                var gamesWithTheSameFirstLetter = groupedGames[firstLetter] ?? []
                gamesWithTheSameFirstLetter.append(game)
                groupedGames[firstLetter] = gamesWithTheSameFirstLetter
            } else {
                log.warning("Game named \"\(game.name)\" was skipped.")
            }
        }
        return groupedGames
    }
    
}
