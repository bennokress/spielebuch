//
//  MatchesInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 21.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class MatchesInterpreterImplementation {
    
    private let presenter: MatchesPresenter
    
    init(with presenter: MatchesPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol MatchesInterpreter: class {
    
    /// Takes actions when the GamesView is loading.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes actions when the user filters matches by game.
    /// - Parameter searchTerm: The current content of the search bar.
    func userFilters(by game: Game)
    
    /// Takes actions when the user taps on a match.
    /// - Parameter match: The match the user tapped on.
    /// - Parameter isFilterActive: True if the user filtered prior to tapping on the match.
    func userTapped(_ match: Match, withActiveFilter isFilterActive: Bool)
    
    /// Takes actions when the user taps the "new match" button.
    func userTappedAddMatchButton()
    
    /// Takes action when a new match was added or modified.
    /// - Parameter modifiedMatch: The modified match to be displayed.
    func delegateWasNotified(about modifiedMatch: Match)
    
    /// Takes action when a new match was added or modified.
    func delegateWasNotifiedAboutModifiedMatches()
    
}

extension MatchesInterpreterImplementation: MatchesInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        let matchesViewSetup = setupData ?? VIPViewSetupData.matches(list: matchesList)
        presenter.setup(with: matchesViewSetup)
    }
    
    // MARK: User Actions
    
    func userFilters(by game: Game) {
        let filteredMatchesList = filteredMatches(by: game)
        presenter.updateTable(with: filteredMatchesList)
    }
    
    func userTapped(_ match: Match, withActiveFilter isFilterActive: Bool) {
        presenter.displayMatchDetails(for: match)
        if isFilterActive {
            presenter.filterUsageWasConcluded()
        }
    }
    
    func userTappedAddMatchButton() {
        presenter.displayAddMatchView()
    }
    
    // MARK: Delegate Actions
    
    func delegateWasNotified(about modifiedMatch: Match) {
        presenter.updateTable(with: matchesList)
    }
    
    func delegateWasNotifiedAboutModifiedMatches() {
        presenter.updateTable(with: matchesList)
    }
    
}

// MARK: - Private Helpers

extension MatchesInterpreterImplementation {
    
    private var matchesList: [Match] {
        return Mock.shared.matches
    }
    
    private func filteredMatches(by game: Game) -> [Match] {
        return matchesList.filter { $0.game == game }
    }
    
}
