//
//  GameModificationView.swift
//  Spielebuch
//
//  Created by Benno Kress on 11.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

class GameModificationViewController: VIPViewController {
    
    private var interpreter: GameModificationInterpreter?
    
    private var game: Game? = nil
    
    override func loadView() {
        super.loadView()
        initializeVIP()
        setupView()
    }
    
    // MARK: - Setup
    
    // MARK: View
    private func setupView() {
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    // MARK: Navigation Bar
    private func setupNavigationBar() {
        // TODO: Show Cancel and Save BarButtonItems
        title = "New Game"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - VIP Cycle
    
    /// Initializes corresponding Interpreter and Presenter
    private func initializeVIP() {
        let presenter = GameModificationPresenterImplementation(for: self as GameModificationView)
        self.interpreter = GameModificationInterpreterImplementation(with: presenter)
    }
    
    /// Unwind Segue Setup
    @IBAction func unwindToGameModificationView(sender: UIStoryboardSegue) {
        VIPSegue.unwindToGameModification.prepare(from: sender, to: self as VIPViewController)
    }
    
}

// MARK: - GameModificationView Protocol
protocol GameModificationView: class {
    
    /// Makes the method from the superclass VIPViewController visible in order to pass data to a segue destination view controller.
    func setPassOnData(to passOnData: VIPViewSetupData?)
    
    /// Normally used to display the value, but used in console for demonstration purposes here.
    func fillFieldsWithCurrentValues(of game: Game)
    
}

// MARK: - GameModificationView Conformance
extension GameModificationViewController: GameModificationView {
    
    func fillFieldsWithCurrentValues(of game: Game) {
        log.info("Filling fields for \(game.name)")
    }
    
}

