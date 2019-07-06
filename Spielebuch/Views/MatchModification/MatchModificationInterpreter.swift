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
    
    // MARK: View Data Management
    
    private var originalMatch: Match? = nil
    
    private var date: Date? = nil
    private var game: Game? = nil
    private var scores: [Score] = []
    
    private var newMatch: Match? { return Match.initIfPossible(date: date, game: game, scores: scores) }
    private var isOriginalMatchEdited: Bool { return newMatch != originalMatch }
    private var isValidMatchConstructable: Bool { return newMatch != nil }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol MatchModificationInterpreter: class {
    
    /// Takes actions when the GamesView is loading.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes action when the user chose a date
    /// - Parameter date: The date of the match.
    func userChose(_ date: Date)
    
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
        if let setupData = setupData, case let VIPViewSetupData.matchModification(includedMatch) = setupData, let match = includedMatch {
            // Edit Mode
            originalMatch = match
            date = match.date
            game = match.game
            scores = match.scores
            presenter.setupInEditMode(for: match)
        } else {
            guard let randomGame = Mock.shared.games.randomElement() else { return }
            let now = Date()
            game = randomGame
            date = now
            presenter.setupInCreationMode(with: randomGame, on: now)
        }
    }
    
    // MARK: User Actions
    
    func userChose(_ date: Date) {
        self.date = date
        presenter.matchWasUpdated(to: date)
        presenter.matchIsSavable(isValidMatchConstructable && isOriginalMatchEdited)
    }
    
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
