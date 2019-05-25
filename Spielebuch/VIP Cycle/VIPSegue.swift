//
//  VIPSegue.swift
//  Spielebuch
//
//  Created by Benno Kress on 25.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

enum VIPSegue: String {
    
    // MARK: - Cases
    // IMPORTANT: The cases have to be identically named to the identifier of the UIStoryboardSegue they represent!
    
    // MARK: Normal Segues
    
    // MARK: Unwind Segues
    case unwindToHome
    
    // MARK: - Public functions
    
    /// Passes data from the source view controller to the destination view controller of a normal segue.
    func prepare(for segue: UIStoryboardSegue, with passOnData: VIPViewSetupData?) {
        guard let destinationViewController = segue.destination as? VIPViewController else { return }
        destinationViewController.setSetupData(to: passOnData)
    }
    
    /// Performs a normal segue.
    func perform(from sourceViewController: VIPViewController) {
        sourceViewController.performSegue(withIdentifier: self.rawValue, sender: nil)
    }
    
    /// Passes data from the source view controller to the destination view controller of an unwind segue.
    func prepare(from unwindSegue: UIStoryboardSegue, to destinationViewController: VIPViewController) {
        guard let sourceViewController = unwindSegue.source as? VIPViewController else { return }
        destinationViewController.setSetupData(to: sourceViewController.passOnData)
    }
    
}