//
//  MatchesPresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 21.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class MatchesPresenterImplementation {
    
    private unowned var view: MatchesView
    
    init(for view: MatchesView) {
        self.view = view
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol MatchesPresenter: class {
    
    /// Populates the GamesView with data.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func setup(with setupData: VIPViewSetupData?)
    
    /// Provides the matches for the MatchesView.
    /// - Parameter matchesList: The matches to be displayed.
    func updateTable(with matchesList: [Match])
    
    /// Instructs the MatchesView to display the details for a match.
    /// - Parameter match: The match of which the details should be displayed.
    func displayMatchDetails(for match: Match)
    
    /// Instructs the MatchesView to display a MatchModificationView.
    func displayAddMatchView()
    
    /// Instructs the MatchesView to remove the applied filter.
    func filterUsageWasConcluded()
    
}

extension MatchesPresenterImplementation: MatchesPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.matches(list) = data else { return }
        let groupedMatches = group(matches: list)
        view.updateMatches(from: groupedMatches)
    }
    
    func updateTable(with matchesList: [Match]) {
        let groupedMatches = group(matches: matchesList)
        view.updateMatches(from: groupedMatches)
    }
    
    func displayMatchDetails(for match: Match) {
        let matchData = VIPViewSetupData.matchDetail(match: match)
        view.showMatchDetailView(with: matchData)
    }
    
    func displayAddMatchView() {
        view.showNewMatchView()
    }
    
    func filterUsageWasConcluded() {
        log.info("Not yet implemented")
    }
    
}

// MARK: - Private Helpers

extension MatchesPresenterImplementation {
    
    private func group(matches: [Match]) -> [String : [Match]] {
        log.info("Grouping matches is not yet correctly implemented.")
        // TODO: Group matches by date maybe?
        let sortedMatches = matches.sorted { $0.game.name.lowercased() < $1.game.name.lowercased() }
        var groupedMatches: [String : [Match]] = [:]
        for match in sortedMatches {
            if let firstCharacter = match.game.name.first, (firstCharacter.isLetter || firstCharacter.isNumber) {
                let firstLetter = firstCharacter.uppercased()
                var matchesWithTheSameFirstLetter = groupedMatches[firstLetter] ?? []
                matchesWithTheSameFirstLetter.append(match)
                groupedMatches[firstLetter] = matchesWithTheSameFirstLetter
            } else {
                log.warning("Match of \"\(match.game.name)\" was skipped.")
            }
        }
        return groupedMatches
    }
    
}
