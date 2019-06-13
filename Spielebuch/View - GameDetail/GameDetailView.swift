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
    var delegate: GameDetailDelegate? = nil
    
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
    
}

// MARK: - Bar Button Items
extension GameDetailViewController {
    
    @objc func editGame() {
        interpreter?.userTappedEditButton()
    }
    
}

// MARK: - GameDetailView Protocol
protocol GameDetailView: class {
    
    /// Used to display the game properties
    func showDetails(of game: Game)
    
    /// Presents the Edit Game View
    func showEditGameView()
    
    func notifyGamesListAboutChange()
    
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
        editGameViewController.setup(with: .gameModification(game: game))
        let editGameNavigationController = UINavigationController(rootViewController: editGameViewController)
        present(editGameNavigationController, animated: true)
    }
    
    func notifyGamesListAboutChange() {
        delegate?.gamesWereModified()
    }
    
}

extension GameDetailViewController: GameModificationDelegate {
    
    func gameDetailChanged(for game: Game) {
        interpreter?.received(game)
    }
    
}

// MARK: - GameDetailDelegate
protocol GameDetailDelegate {
    func gamesWereModified()
}

