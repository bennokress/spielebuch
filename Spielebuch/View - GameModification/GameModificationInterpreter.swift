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
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes action on a new game saved by the user
    func userTappedSaveGameButton(name: String)
    
    /// Takes action when the game modification is cancelled by the user
    func userTappedCancelButton()
    
    func userEditedNameTextField(to textFieldValue: String?, for game: Game?)
    
}

extension GameModificationInterpreterImplementation: GameModificationInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
    // MARK: User Actions
    
    func userTappedSaveGameButton(name: String) {
        // TODO: Check validity of the provided data?
        let newGame = Game(named: name)
        Mock.shared.save(newGame)
        presenter.gameSavedSuccessfully()
    }
    
    func userTappedCancelButton() {
        presenter.cancelRequested()
    }
    
    func userEditedNameTextField(to textFieldValue: String?, for game: Game?) {
        guard let name = textFieldValue, name.count > 0 else {
            presenter.nameTextFieldIsEmpty()
            return
        }
        if let originalGame = game, originalGame.name == name {
            presenter.nameIsUnchanged()
        } else {
            presenter.nameTextFieldIsFilled()
        }
    }
    
}

// MARK: - Private Helpers
extension GameModificationInterpreterImplementation {

}
