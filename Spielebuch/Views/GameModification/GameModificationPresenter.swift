//
//  GameModificationPresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 11.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class GameModificationPresenterImplementation {
    
    private unowned var view: GameModificationView
    
    init(for view: GameModificationView) {
        self.view = view
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol GameModificationPresenter: class {
    
    /// Populates the GameModificationView with data.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func setup(with setupData: VIPViewSetupData?)
    
    /// Instructs the GameModificationView to be dismissed and notify delegates about the modified game.
    /// - Parameter savedGame: The modified game.
    func gameSavedSuccessfully(_ savedGame: Game)
    
    /// Instructs the GameModificationView to be dismissed.
    func cancelRequested()
    
    /// Instructs the GameModificationView to disable the save option.
    func nameTextFieldIsEmpty()
    
    /// Instructs the GameModificationView to enable the save button.
    func nameTextFieldIsFilled()
    
    /// Instructs the GameModificationView to disable the save button.
    func nameIsUnchanged()
    
}

extension GameModificationPresenterImplementation: GameModificationPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.gameModification(game) = data, let gameToModify = game else {
            view.setTitle(to: "New Game")
            return
        }
        view.setTitle(to: "Edit Game")
        view.fillFieldsWithCurrentValues(of: gameToModify)
    }
    
    func gameSavedSuccessfully(_ savedGame: Game) {
        view.notifyDelegates(about: savedGame)
        view.dismiss()
    }
    
    func cancelRequested() {
        view.dismiss()
    }
    
    func nameTextFieldIsEmpty() {
        view.disableSaveButton()
    }
    
    func nameTextFieldIsFilled() {
        view.enableSaveButton()
    }
    
    func nameIsUnchanged() {
        view.disableSaveButton()
    }
    
}

// MARK: - Private Helpers

extension GameModificationPresenterImplementation {
    
}
