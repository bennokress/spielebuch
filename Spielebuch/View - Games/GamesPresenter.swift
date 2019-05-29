//
//  GamesPresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 29.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class GamesPresenterImplementation {
    
    private unowned var view: GamesView
    
    /// This initializer is called when a new GamesView is created.
    init(for view: GamesView) {
        self.view = view
    }
    
}

// MARK: - GamesPresenter Protocol
protocol GamesPresenter: class {
    
    /// Display the provided data on the GamesView
    func setup(with setupData: VIPViewSetupData?)
    
}

// MARK: - GamesPresenter Conformance
extension GamesPresenterImplementation: GamesPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.games(someBoolValue) = data else { return }
        view.doSomething(with: someBoolValue)
    }
    
}
