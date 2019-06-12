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
    
    /// This initializer is called when a new GameModificationView is created.
    init(for view: GameModificationView) {
        self.view = view
    }
    
}

// MARK: - GameModificationPresenter Protocol
protocol GameModificationPresenter: class {
    
    /// Display the provided data on the GameModificationView
    func setup(with setupData: VIPViewSetupData?)
    
    func gameSavedSuccessfully()
    
    func cancelRequested()
    
    func nameTextFieldIsEmpty()
    
    func nameTextFieldIsFilled()
    
    func nameIsUnchanged()
    
}

// MARK: - GameModificationPresenter Conformance
extension GameModificationPresenterImplementation: GameModificationPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.gameModification(game) = data, let gameToModify = game else {
            view.setTitle(to: "New Game")
            return
        }
        view.setTitle(to: "Edit Game")
        view.fillFieldsWithCurrentValues(of: gameToModify)
    }
    
    func gameSavedSuccessfully() {
        view.notifyDelegate()
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
