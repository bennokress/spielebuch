//
//  GameDetailInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 10.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class GameDetailInterpreterImplementation {
    
    private let presenter: GameDetailPresenter
    
    /// This initializer is called when a new GameDetailView is created.
    init(with presenter: GameDetailPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - Public Methods
protocol GameDetailInterpreter: class {
    
    /// Takes the necessary actions when the GameDetailView is being initialized
    func loadView(with setupData: VIPViewSetupData?)
    
    /// Takes the necessary actions when the GameDetailView is finished loading
    func viewWillAppear(with setupData: VIPViewSetupData?)
    
}

extension GameDetailInterpreterImplementation: GameDetailInterpreter {
    
    // MARK: View Actions
    
    func loadView(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
    func viewWillAppear(with setupData: VIPViewSetupData?) {
        
    }
    
    // MARK: User Actions
    
}

// MARK: - Private Helpers
extension GameDetailInterpreterImplementation {
    
}
