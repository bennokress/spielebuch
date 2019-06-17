//
//  PlayerModificationInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 17.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class PlayerModificationInterpreterImplementation {
    
    private let presenter: PlayerModificationPresenter
    
    init(with presenter: PlayerModificationPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol PlayerModificationInterpreter: class {
    
    /// Takes actions when the PlayerModificationView is loading.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func viewIsLoading(with setupData: VIPViewSetupData?)
    
    /// Takes actions when the user wants to save a player.
    /// - Parameter name: The name of the player.
    /// - Parameter player: [Optional] The existing player that should be modified. A new player should be created if this is nil.
    func userTappedSavePlayerButton(name: String?, for player: Player?)
    
    /// Takes action when the user cancels the player modification.
    func userTappedCancelButton()
    
    /// Takes action when the user edits the name text field by typing or deleting a character.
    /// - Parameter textFieldValue: The new content of the name text field.
    /// - Parameter player: [Optional] The existing player that is currently modified by the user. A new player is being created if this is nil.
    func userEditedNameTextField(to textFieldValue: String?, for player: Player?)
    
}

extension PlayerModificationInterpreterImplementation: PlayerModificationInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
    // MARK: User Actions
    
    func userTappedSavePlayerButton(name: String?, for player: Player?) {
        guard let name = name?.withTrimmedWhitespace else {
            log.error("The save button should not have been active!"); return
        }
        let savedPlayer = Player(firstName: name, lastName: "Nachname", nickname: nil, base64Image: nil)
        if let originalPlayer = player {
            Mock.shared.modify(originalPlayer, toBe: savedPlayer)
        } else {
            Mock.shared.save(savedPlayer)
        }
        presenter.playerSavedSuccessfully(savedPlayer)
    }
    
    func userTappedCancelButton() {
        presenter.cancelRequested()
    }
    
    func userEditedNameTextField(to textFieldValue: String?, for player: Player?) {
        guard let name = textFieldValue?.withTrimmedWhitespace, name.count > 0 else {
            presenter.nameTextFieldIsEmpty()
            return
        }
        if let originalPlayer = player, originalPlayer.firstName == name {
            presenter.nameIsUnchanged()
        } else {
            presenter.nameTextFieldIsFilled()
        }
    }
    
    // MARK: Delegate Actions
    
}

// MARK: - Private Helpers

extension PlayerModificationInterpreterImplementation {
    
}
