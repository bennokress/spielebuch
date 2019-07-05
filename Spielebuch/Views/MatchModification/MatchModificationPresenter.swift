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
    /// - Parameter setupData: Data containing the match to be modified. Set by the preceeding view controller.
    func setupInEditMode(with setupData: VIPViewSetupData)
    
    /// Populates the MatchModificationView with empty data.
    func setupInCreationMode()
    
    /// Instructs the MatchModificationView to be dismissed and notify delegates about the modified match.
    /// - Parameter savedMatch: The modified match.
    func matchSavedSuccessfully(_ savedMatch: Match)
    
    /// Instructs the MatchModificationView to be dismissed.
    func cancelRequested()
    
    /// Instructs the MatchModificationView to display the updated game of the match.
    /// - Parameter game: The game of the match.
    func matchWasUpdated(to game: Game)
    
}

extension MatchModificationPresenterImplementation: MatchModificationPresenter {
    
    func setupInEditMode(with setupData: VIPViewSetupData) {
        guard case let VIPViewSetupData.matchModification(match) = setupData, let matchToModify = match else {
            log.warning("The view should appear in Edit Mode, but no match was found. Moving on in Creation Mode.")
            setupInCreationMode()
            return
        }
        view.setTitle(to: "Edit Match")
        view.fillFieldsWithCurrentValues(of: matchToModify)
    }
    
    func setupInCreationMode() {
        view.setTitle(to: "New Match")
    }
    
    func matchSavedSuccessfully(_ savedMatch: Match) {
        view.notifyDelegates(about: savedMatch)
        view.dismiss()
    }
    
    func cancelRequested() {
        view.dismiss()
    }
    
    func matchWasUpdated(to game: Game) {
        view.set(game)
    }
    
}

// MARK: - Private Helpers

extension MatchModificationPresenterImplementation {
    
    // private functions …
    
}
