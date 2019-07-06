//
//  MatchModificationPresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 24.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class MatchModificationPresenterImplementation {
    
    private unowned var view: MatchModificationView
    
    init(for view: MatchModificationView) {
        self.view = view
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol MatchModificationPresenter: class {
    
    /// Populates the MatchModificationView with data from an existing match.
    /// - Parameter match: The match to be modified.
    func setupInEditMode(for match: Match)
    
    /// Populates the MatchModificationView with empty data.
    /// - Parameter game: The chosen game for the match.
    /// - Parameter date: The date of the match.
    func setupInCreationMode(with game: Game, on date: Date)
    
    /// Instructs the MatchModificationView to be dismissed and notify delegates about the modified match.
    /// - Parameter savedMatch: The modified match.
    func matchSavedSuccessfully(_ savedMatch: Match)
    
    /// Instructs the MatchModificationView to be dismissed.
    func cancelRequested()
    
    /// Instructs the MatchModificationView to display the updated date of the match.
    /// - Parameter date: The date of the match.
    func matchWasUpdated(to date: Date)
    
}

extension MatchModificationPresenterImplementation: MatchModificationPresenter {
    
    func setupInEditMode(for match: Match) {
        view.setTitle(to: match.game.name)
        view.set(match.date)
    }
    
    func setupInCreationMode(with game: Game, on date: Date) {
        view.setTitle(to: game.name)
        view.set(date)
    }
    
    func matchSavedSuccessfully(_ savedMatch: Match) {
        view.notifyDelegates(about: savedMatch)
        view.dismiss()
    }
    
    func cancelRequested() {
        view.dismiss()
    }
    
    func matchWasUpdated(to date: Date) {
        view.set(date)
    }
    
}

// MARK: - Private Helpers

extension MatchModificationPresenterImplementation {
    
    // private functions …
    
}
