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
    /// - Parameter firstName: The first name of the player.
    /// - Parameter lastName: The last name of the player.
    /// - Parameter nickname: The nickname of the player.
    /// - Parameter player: [Optional] The existing player that should be modified. A new player should be created if this is nil.
    func userTappedSavePlayerButton(firstName: String?, lastName: String?, nickname: String?, for player: Player?)
    
    /// Takes action when the user cancels the player modification.
    func userTappedCancelButton()
    
    /// Takes action when the user edits the name text field by typing or deleting a character.
    /// - Parameter firstNameTextFieldValue: The new content of the first name text field.
    /// - Parameter lastNameTextFieldValue: The new content of the last name text field.
    /// - Parameter nicknameTextFieldValue: The new content of the nickname text field.
    /// - Parameter player: [Optional] The existing player that is currently modified by the user. A new player is being created if this is nil.
    func userEditedTextFields(to firstNameTextFieldValue: String?, _ lastNameTextFieldValue: String?, _ nicknameTextFieldValue: String?, for player: Player?)
    
}

extension PlayerModificationInterpreterImplementation: PlayerModificationInterpreter {
    
    // MARK: View Actions
    
    func viewIsLoading(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
    // MARK: User Actions
    
    func userTappedSavePlayerButton(firstName: String?, lastName: String?, nickname: String?, for player: Player?) {
        guard let firstName = firstName.withTrimmedWhitespace, let lastName = lastName.withTrimmedWhitespace else {
            log.error("The save button should not have been active!"); return
        }
        let nickname = nickname.withTrimmedWhitespace
        let savedPlayer = Player(firstName: firstName, lastName: lastName, nickname: nickname, base64Image: nil)
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
    
    func userEditedTextFields(to firstNameTextFieldValue: String?, _ lastNameTextFieldValue: String?, _ nicknameTextFieldValue: String?, for player: Player?) {
        guard let firstName = firstNameTextFieldValue.withTrimmedWhitespace, let lastName = lastNameTextFieldValue.withTrimmedWhitespace else {
            presenter.requiredTextFieldsAreNotYetFilled()
            return
        }
        let nickname = nicknameTextFieldValue.withTrimmedWhitespace
        if let originalPlayer = player, originalPlayer.firstName == firstName, originalPlayer.lastName == lastName, originalPlayer.nickname == nickname {
            presenter.playerIsUnchanged()
        } else {
            presenter.textFieldsAreFilled()
        }
    }
    
    // MARK: Delegate Actions
    
}

// MARK: - Private Helpers

extension PlayerModificationInterpreterImplementation {
    
}
