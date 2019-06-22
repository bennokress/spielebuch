//
//  MatchDetailInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 22.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class MatchDetailInterpreterImplementation {
    
    private let presenter: MatchDetailPresenter
    
    init(with presenter: MatchDetailPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol MatchDetailInterpreter: class {
    
    /// Takes actions when the GamesView is loading.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes action when the user wants to edit the shown match.
    func userTappedEditButton(for match: Match?)
    
    /// Takes action when the match displayed by the corresponding view was modified elsewhere.
    /// - Parameter modifiedMatch: The modified match to be displayed.
    func delegateReceived(_ modifiedMatch: Match)
    
}

extension MatchDetailInterpreterImplementation: MatchDetailInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
    // MARK: User Actions
    
    func userTappedEditButton(for match: Match?) {
        guard let match = match else { return }
        let matchModificationViewSetupData = VIPViewSetupData.matchModification(match: match)
        presenter.displayEditMatchView(with: matchModificationViewSetupData)
    }
    
    // MARK: Delegate Actions
    
    func delegateReceived(_ modifiedMatch: Match) {
        presenter.showDetails(of: modifiedMatch)
        presenter.requestMatchesListReload()
    }
    
}

// MARK: - Private Helpers

extension MatchDetailInterpreterImplementation {
    
}
