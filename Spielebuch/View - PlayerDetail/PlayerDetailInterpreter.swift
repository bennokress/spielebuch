//
//  PlayerDetailInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 17.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class PlayerDetailInterpreterImplementation {
    
    private let presenter: PlayerDetailPresenter
    
    init(with presenter: PlayerDetailPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol PlayerDetailInterpreter: class {
    
    /// Takes actions when the PlayerDetailView is loading.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes action when the user wants to edit the shown player.
    func userTappedEditButton(for player: Player?)
    
    /// Takes action when the player displayed by the corresponding view was modified elsewhere.
    /// - Parameter modifiedPlayer: The modified player to be displayed.
    func delegateReceived(_ modifiedPlayer: Player)
    
}

extension PlayerDetailInterpreterImplementation: PlayerDetailInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
    // MARK: User Actions
    
    func userTappedEditButton(for player: Player?) {
        guard let player = player else { return }
        let playerModificationViewSetupData = VIPViewSetupData.playerModification(player: player)
        presenter.displayEditPlayerView(with: playerModificationViewSetupData)
    }
    
    // MARK: Delegate Actions
    
    func delegateReceived(_ modifiedPlayer: Player) {
        presenter.showDetails(of: modifiedPlayer)
        presenter.requestPlayersListReload()
    }
    
}

// MARK: - Private Helpers

extension PlayerDetailInterpreterImplementation {
    
}
