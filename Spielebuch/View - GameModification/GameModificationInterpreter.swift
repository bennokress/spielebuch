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
    func userTappedSaveGameButton(name: String?, for game: Game?)
    
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
    
    func userTappedSaveGameButton(name: String?, for game: Game?) {
        guard let name = name else {
            log.error("The save button should not have been active!")
            return
        }
        let savedGame = Game(named: name)
        if let originalGame = game {
            Mock.shared.modify(originalGame, toBe: savedGame)
        } else {
            Mock.shared.save(savedGame)
        }
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
