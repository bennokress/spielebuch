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
    
    /// This initializer is called when a new GameDetailView is created.
    init(for view: GameDetailView) {
        self.view = view
    }
    
}

// MARK: - GameDetailPresenter Protocol
protocol GameDetailPresenter: class {
    
    /// Display the provided data on the GameDetailView
    func setup(with setupData: VIPViewSetupData?)
    
    func editGameViewNeeded()
    
    func showDetails(of game: Game)
    
    func requestGamesListReload()
    
}

// MARK: - GameDetailPresenter Conformance
extension GameDetailPresenterImplementation: GameDetailPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.gameDetail(game) = data else { return }
        showDetails(of: game)
    }
    
    func editGameViewNeeded() {
        view.showEditGameView()
    }
    
    func showDetails(of game: Game) {
        view.showDetails(of: game)
    }
    
    func requestGamesListReload() {
        view.notifyGamesListAboutChange()
    }
    
}
