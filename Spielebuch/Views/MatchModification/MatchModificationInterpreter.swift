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
    func userTappedSaveMatchButton()
    
    /// Takes action when the user cancels the match modification.
    func userTappedCancelButton()
    
    /// DUMMY - Adds 2-4 more or less random scores.
    func userTappedAddScoreButton()
    
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
    
    func userTappedSaveMatchButton() {
        guard let savedMatch = newMatch else {
            log.error("The match could not be constructed, the save button should not have been activated!")
            return
        }
        if let originalMatch = originalMatch, isOriginalMatchEdited {
            Mock.shared.modify(originalMatch, toBe: savedMatch)
        } else {
            Mock.shared.save(savedMatch)
        }
        presenter.matchSavedSuccessfully(savedMatch)
    }
    
    func userTappedCancelButton() {
        presenter.cancelRequested()
    }
    
    func userTappedAddScoreButton() {
        var newScores: [Score] = []
        for player in playersForNewMatch {
            let scoreValue = Int.random(in: 0...100)
            newScores.append(Score(player: player, isScoreOfStartingPlayer: player.fullName == "Sandra Gaede", value: Double(scoreValue)))
        }
        self.scores = newScores
        presenter.matchWasUpdated(with: newScores)
        presenter.matchIsSavable(isValidMatchConstructable && isOriginalMatchEdited)
    }
    
    // MARK: Delegate Actions
    
}

// MARK: - Private Helpers

extension MatchModificationInterpreterImplementation {
    
    // DUMMY FUNCTIONS
    
    var playersForNewMatch: [Player] {
        var playerPool = Mock.shared.players
        let benno = playerPool.first { $0.fullName == "Benno Kress" }!
        let sandra = playerPool.first { $0.fullName == "Sandra Gaede" }!
        var players = [benno, sandra]
        playerPool = playerPool.filter { $0 != benno && $0 != sandra }
        for _ in 3...4 where Bool.random() {
            // Randomly adds 0-2 Players (Player 3 & Player 4)
            let additionalPlayer = playerPool.randomElement()!
            players.append(additionalPlayer)
            playerPool = playerPool.filter { $0 != additionalPlayer }
        }
        return players
    }
    
}
