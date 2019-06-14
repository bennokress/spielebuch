//
//  GameDetailInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 10.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class GameDetailInterpreterImplementation {
    
    private let presenter: GameDetailPresenter
    
    init(with presenter: GameDetailPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol GameDetailInterpreter: class {
    
    /// Takes actions when the GameDetailView is loading.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes action when the user wants to edit the shown game.
    func userTappedEditButton(for game: Game?)
    
    /// Takes action when the game displayed by the corresponding view was modified elsewhere.
    /// - Parameter modifiedGame: The modified game to be displayed.
    func delegateReceived(_ modifiedGame: Game)
    
}

extension GameDetailInterpreterImplementation: GameDetailInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
    // MARK: User Actions
    
    func userTappedEditButton(for game: Game?) {
        guard let game = game else { return }
        let gameModificationViewSetupData = VIPViewSetupData.gameModification(game: game)
        presenter.displayEditGameView(with: gameModificationViewSetupData)
    }
    
    // MARK: Delegate Actions
    
    func delegateReceived(_ modifiedGame: Game) {
        presenter.showDetails(of: modifiedGame)
        presenter.requestGamesListReload()
    }
    
}

// MARK: - Private Helpers

extension GameDetailInterpreterImplementation {
    
}
