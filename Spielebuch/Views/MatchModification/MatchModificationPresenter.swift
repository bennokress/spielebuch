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
    
    /// Populates the GamesView with data.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func setup(with setupData: VIPViewSetupData?)
    
    /// Instructs the MatchModificationView to be dismissed and notify delegates about the modified match.
    /// - Parameter savedMatch: The modified match.
    func matchSavedSuccessfully(_ savedMatch: Match)
    
    /// Instructs the MatchModificationView to be dismissed.
    func cancelRequested()
    
}

extension MatchModificationPresenterImplementation: MatchModificationPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.matchModification(match) = data, let matchToModify = match else {
            view.setTitle(to: "New Match")
            return
        }
        view.setTitle(to: "Edit Match")
        view.fillFieldsWithCurrentValues(of: matchToModify)
    }
    
    func matchSavedSuccessfully(_ savedMatch: Match) {
        view.notifyDelegates(about: savedMatch)
        view.dismiss()
    }
    
    func cancelRequested() {
        view.dismiss()
    }
    
}

// MARK: - Private Helpers

extension MatchModificationPresenterImplementation {
    
    // private functions …
    
}
