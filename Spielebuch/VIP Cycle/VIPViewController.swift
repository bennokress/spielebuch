//
//  VIPViewController.swift
//  Spielebuch
//
//  Created by Benno Kress on 25.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

class VIPViewController: UIViewController {
    
    private(set) var setupData: VIPViewSetupData? = nil
    private(set) var passOnData: VIPViewSetupData? = nil
    
    func setSetupData(to setupData: VIPViewSetupData?) {
        self.setupData = setupData
    }
    
    func setPassOnData(to passOnData: VIPViewSetupData?) {
        self.passOnData = passOnData
    }
    
    /// Passes the data in passOnData to the next VIPViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier, let pendingSegue = VIPSegue(rawValue: segueIdentifier) else { return }
        pendingSegue.prepare(for: segue, with: passOnData)
    }
    
}
