//
//  MatchDetailPresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 22.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class MatchDetailPresenterImplementation {
    
    private unowned var view: MatchDetailView
    
    init(for view: MatchDetailView) {
        self.view = view
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol MatchDetailPresenter: class {
    
    /// Populates the GamesView with data.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func setup(with setupData: VIPViewSetupData?)
    
    /// Provides the details of the match to be displayed.
    /// - Parameter match: The match to be displayed.
    func showDetails(of match: Match)
    
    /// Instructs the MatchDetailView to display a MatchModificationView.
    func displayEditMatchView(with setupData: VIPViewSetupData?)
    
    /// Instructs the MatchDetailView to notify delegates about modified matches.
    func requestMatchesListReload()
    
}

extension MatchDetailPresenterImplementation: MatchDetailPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.matchDetail(match) = data else { return }
        view.showDetails(of: match)
    }
    
    func displayEditMatchView(with setupData: VIPViewSetupData?) {
        view.showEditMatchView(with: setupData)
    }
    
    func showDetails(of match: Match) {
        view.showDetails(of: match)
    }
    
    func requestMatchesListReload() {
        view.notifyDelegatesAboutChange()
    }
    
}

// MARK: - Private Helpers

extension MatchDetailPresenterImplementation {
    
}
