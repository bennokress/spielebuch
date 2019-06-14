//
//  GameDetailPresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 10.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class GameDetailPresenterImplementation {
    
    private unowned var view: GameDetailView
    
    init(for view: GameDetailView) {
        self.view = view
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol GameDetailPresenter: class {
    
    /// Populates the GameDetailView with data.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func setup(with setupData: VIPViewSetupData?)
    
    /// Provides the details of the game to be displayed.
    /// - Parameter game: The game to be displayed.
    func showDetails(of game: Game)
    
    /// Instructs the GameDetailView to display a GameModificationView.
    func displayEditGameView(with setupData: VIPViewSetupData?)
    
    /// Instructs the GameDetailView to notify delegates about modified games.
    func requestGamesListReload()
    
}

extension GameDetailPresenterImplementation: GameDetailPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.gameDetail(game) = data else { return }
        showDetails(of: game)
    }
    
    func displayEditGameView(with setupData: VIPViewSetupData?) {
        view.showEditGameView(with: setupData)
    }
    
    func showDetails(of game: Game) {
        view.showDetails(of: game)
    }
    
    func requestGamesListReload() {
        view.notifyDelegatesAboutChange()
    }
    
}

// MARK: - Private Helpers

extension GameDetailPresenterImplementation {
    
}
