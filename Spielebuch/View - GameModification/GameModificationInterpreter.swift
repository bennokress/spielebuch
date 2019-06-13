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
    
    init(with presenter: GameModificationPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol GameModificationInterpreter: class {
    
    /// Takes actions when the GameModificationView is loading.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes actions when the user wants to save a game.
    /// - Parameter name: The name of the game.
    /// - Parameter game: [Optional] The existing game that should be modified. A new game should be created if this is nil.
    func userTappedSaveGameButton(name: String?, for game: Game?)
    
    /// Takes action when the user cancels the game modification.
    func userTappedCancelButton()
    
    /// Takes action when the user edits the name text field by typing or deleting a character.
    /// - Parameter textFieldValue: The new content of the name text field.
    /// - Parameter game: [Optional] The existing game that is currently modified by the user. A new game is being created if this is nil.
    func userEditedNameTextField(to textFieldValue: String?, for game: Game?)
    
}

extension GameModificationInterpreterImplementation: GameModificationInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
    // MARK: User Actions
    
    func userTappedSaveGameButton(name: String?, for game: Game?) {
        guard let name = name?.withTrimmedWhitespace else {
            log.error("The save button should not have been active!"); return
        }
        let savedGame = Game(named: name)
        if let originalGame = game {
            Mock.shared.modify(originalGame, toBe: savedGame)
        } else {
            Mock.shared.save(savedGame)
        }
        presenter.gameSavedSuccessfully(savedGame)
    }
    
    func userTappedCancelButton() {
        presenter.cancelRequested()
    }
    
    func userEditedNameTextField(to textFieldValue: String?, for game: Game?) {
        guard let name = textFieldValue?.withTrimmedWhitespace, name.count > 0 else {
            presenter.nameTextFieldIsEmpty()
            return
        }
        if let originalGame = game, originalGame.name == name {
            presenter.nameIsUnchanged()
        } else {
            presenter.nameTextFieldIsFilled()
        }
    }
    
    // MARK: Delegate Actions
    
}

// MARK: - Private Helpers

extension GameModificationInterpreterImplementation {

}
