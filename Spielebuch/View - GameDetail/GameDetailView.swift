//
//  GameDetailView.swift
//  Spielebuch
//
//  Created by Benno Kress on 10.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

class GameDetailViewController: VIPViewController {
    
    private var interpreter: GameDetailInterpreter?
    
    private var game: Game? = nil
    
    override func loadView() {
        super.loadView()
        initializeVIP()
        interpreter?.loadView(with: setupData)
        setupView()
    }
    
    // MARK: - Setup
    
    // MARK: View
    private func setupView() {
        view.backgroundColor = .white
//        setupGameDetailView()
        setupNavigationBar()
    }
    
    // MARK: Navigation Bar
    private func setupNavigationBar() {
//        title = game.name
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let editGameBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(editGame))
        navigationItem.rightBarButtonItem = editGameBarButtonItem
    }
    
    // MARK: - VIP Cycle
    
    /// Initializes corresponding Interpreter and Presenter
    private func initializeVIP() {
        let presenter = GameDetailPresenterImplementation(for: self as GameDetailView)
        self.interpreter = GameDetailInterpreterImplementation(with: presenter)
    }
    
    /// Unwind Segue Setup
    @IBAction func unwindToGameDetailView(sender: UIStoryboardSegue) {
        VIPSegue.unwindToGameDetail.prepare(from: sender, to: self as VIPViewController)
    }
    
}

// MARK: - Bar Button Items
extension GameDetailViewController {
    
    @objc func editGame() {
        interpreter?.userTappedEditButton()
    }
    
}

// MARK: - GameDetailView Protocol
protocol GameDetailView: class {
    
    /// Makes the method from the superclass VIPViewController visible in order to pass data to a segue destination view controller.
    func setPassOnData(to passOnData: VIPViewSetupData?)
    
    /// Used to display the game properties
    func showDetails(of game: Game)
    
    /// Presents the Edit Game View
    func showEditGameView()
    
}

// MARK: - GameDetailView Conformance
extension GameDetailViewController: GameDetailView {
    
    func showDetails(of game: Game) {
        self.game = game
        title = game.name
    }
    
    func showEditGameView() {
        let editGameViewController = GameModificationViewController()
        editGameViewController.delegate = self
        editGameViewController.setSetupData(to: .gameModification(game: game))
        let editGameNavigationController = UINavigationController(rootViewController: editGameViewController)
        present(editGameNavigationController, animated: true)
    }
    
}

extension GameDetailViewController: GameModificationDelegate {
    
    func gameChanged() {
        log.verbose("Must reload game from Backend")
    }
    
}

