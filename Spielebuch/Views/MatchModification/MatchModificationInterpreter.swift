//
//  MatchModificationInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 24.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class MatchModificationInterpreterImplementation {
    
    private let presenter: MatchModificationPresenter
    
    init(with presenter: MatchModificationPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol MatchModificationInterpreter: class {
    
    /// Takes actions when the GamesView is loading.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes actions when the user wants to save a match.
    /// - Parameter game: The played game.
    /// - Parameter date: The date of the match.
    /// - Parameter game: [Optional] The existing match that should be modified. A new match should be created if this is nil.
    func userTappedSaveMatchButton(game: Game, on date: Date, for match: Match?)
    
    /// Takes action when the user cancels the match modification.
    func userTappedCancelButton()
    
}

extension MatchModificationInterpreterImplementation: MatchModificationInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
    // MARK: User Actions
    
    func userTappedSaveMatchButton(game: Game, on date: Date, for match: Match?) {
        let savedMatch = Match(date: date, game: game, scores: [])
        if let originalMatch = match {
            Mock.shared.modify(originalMatch, toBe: savedMatch)
        } else {
            Mock.shared.save(savedMatch)
        }
        presenter.matchSavedSuccessfully(savedMatch)
    }
    
    func userTappedCancelButton() {
        presenter.cancelRequested()
    }
    
    // MARK: Delegate Actions
    
}

// MARK: - Private Helpers

extension MatchModificationInterpreterImplementation {
    
    // private functions …
    
}
