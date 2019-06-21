//
//  PlayerDetailPresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 17.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class PlayerDetailPresenterImplementation {
    
    private unowned var view: PlayerDetailView
    
    init(for view: PlayerDetailView) {
        self.view = view
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol PlayerDetailPresenter: class {
    
    /// Populates the PlayerDetailView with data.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func setup(with setupData: VIPViewSetupData?)
    
    /// Provides the details of the player to be displayed.
    /// - Parameter player: The player to be displayed.
    func showDetails(of player: Player)
    
    /// Instructs the PlayerDetailView to display a PlayerModificationView.
    func displayEditPlayerView(with setupData: VIPViewSetupData?)
    
    /// Instructs the PlayerDetailView to notify delegates about modified players.
    func requestPlayersListReload()
    
}

extension PlayerDetailPresenterImplementation: PlayerDetailPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.playerDetail(player) = data else { return }
        showDetails(of: player)
    }
    
    func displayEditPlayerView(with setupData: VIPViewSetupData?) {
        view.showEditPlayerView(with: setupData)
    }
    
    func showDetails(of player: Player) {
        view.showDetails(of: player)
    }
    
    func requestPlayersListReload() {
        view.notifyDelegatesAboutChange()
    }
    
}

// MARK: - Private Helpers

extension PlayerDetailPresenterImplementation {
    
}
