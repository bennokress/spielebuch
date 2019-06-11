//
//  GameModificationInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 11.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class GameModificationInterpreterImplementation {
    
    private let presenter: GameModificationPresenter
    
    /// This initializer is called when a new GameModificationView is created.
    init(with presenter: GameModificationPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - Public Methods
protocol GameModificationInterpreter: class {
    
    /// Takes the necessary actions when the GameModificationView is finished loading
    func viewWillAppear(with setupData: VIPViewSetupData?)
    
}

extension GameModificationInterpreterImplementation: GameModificationInterpreter {
    
    // MARK: View Actions
    
    func viewWillAppear(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
    // MARK: User Actions
    
}

// MARK: - Private Helpers
extension GameModificationInterpreterImplementation {

}
