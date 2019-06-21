//
//  PlayerModificationPresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 17.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class PlayerModificationPresenterImplementation {
    
    private unowned var view: PlayerModificationView
    
    init(for view: PlayerModificationView) {
        self.view = view
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

protocol PlayerModificationPresenter: class {
    
    /// Populates the PlayerModificationView with data.
    /// - Parameter setupData: [Optional] Data needed to populate the view. Set by the preceeding view controller.
    func setup(with setupData: VIPViewSetupData?)
    
    /// Instructs the PlayerModificationView to be dismissed and notify delegates about the modified player.
    /// - Parameter savedPlayer: The modified player.
    func playerSavedSuccessfully(_ savedPlayer: Player)
    
    /// Instructs the PlayerModificationView to be dismissed.
    func cancelRequested()
    
    /// Instructs the PlayerModificationView to disable the save option.
    func requiredTextFieldsAreNotYetFilled()
    
    /// Instructs the PlayerModificationView to enable the save button.
    func textFieldsAreFilled()
    
    /// Instructs the PlayerModificationView to disable the save button.
    func playerIsUnchanged()
    
}

extension PlayerModificationPresenterImplementation: PlayerModificationPresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.playerModification(player) = data, let playerToModify = player else {
            view.setTitle(to: "New Player")
            return
        }
        view.setTitle(to: "Edit Player")
        view.fillFieldsWithCurrentValues(of: playerToModify)
    }
    
    func playerSavedSuccessfully(_ savedPlayer: Player) {
        view.notifyDelegates(about: savedPlayer)
        view.dismiss()
    }
    
    func cancelRequested() {
        view.dismiss()
    }
    
    func requiredTextFieldsAreNotYetFilled() {
        view.disableSaveButton()
    }
    
    func textFieldsAreFilled() {
        view.enableSaveButton()
    }
    
    func playerIsUnchanged() {
        view.disableSaveButton()
    }
    
}

// MARK: - Private Helpers

extension PlayerModificationPresenterImplementation {
    
}
