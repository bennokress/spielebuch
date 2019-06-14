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
    var delegates: [GameDetailDelegate] = []
    
    // Data
    private var game: Game? = nil
    
    // View Components
    private let editGameBarButtonItem = UIBarButtonItem()
    
}

// MARK: - View Lifecycle

extension GameDetailViewController {
    
    override func loadView() {
        super.loadView()
        initializeVIP()
        interpreter?.viewIsLoading(with: setupData)
        setupView()
    }
    
}

// MARK: - View Setup

extension GameDetailViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    // MARK: Navigation Bar
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        editGameBarButtonItem.title = "Edit"
        editGameBarButtonItem.style = .plain
        editGameBarButtonItem.target = self
        editGameBarButtonItem.action = #selector(editGame)
        
        navigationItem.rightBarButtonItem = editGameBarButtonItem
    }
    
    @objc func editGame() {
        interpreter?.userTappedEditButton(for: game)
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

extension GameDetailViewController {
    
    private func initializeVIP() {
        let presenter = GameDetailPresenterImplementation(for: self as GameDetailView)
        self.interpreter = GameDetailInterpreterImplementation(with: presenter)
    }
    
}

// MARK: View Protocol
// --> Every action provided to the Presenter

protocol GameDetailView: class {
    
    /// Displays the details of the provided game.
    /// - Parameter game: The game to be displayed.
    func showDetails(of game: Game)
    
    /// Presents a prefilled GameModificationView.
    /// - Parameter setupData: The data used to set up the GameDetailView.
    func showEditGameView(with setupData: VIPViewSetupData?)
    
    /// Notifies the delegates about modified games.
    func notifyDelegatesAboutChange()
    
}

extension GameDetailViewController: GameDetailView {
    
    func showDetails(of game: Game) {
        self.game = game
        title = game.name
    }
    
    func showEditGameView(with setupData: VIPViewSetupData?) {
        let editGameViewController = GameModificationViewController()
        editGameViewController.delegates.append(self)
        editGameViewController.setup(with: setupData)
        let editGameNavigationController = UINavigationController(rootViewController: editGameViewController)
        present(editGameNavigationController, animated: true)
    }
    
    func notifyDelegatesAboutChange() {
        delegates.forEach { $0.gamesWereModified() }
    }
    
}

// MARK: - Delegate Implementations

extension GameDetailViewController: GameModificationDelegate {
    
    func gameDetailChanged(for game: Game) {
        interpreter?.delegateReceived(game)
    }
    
}

// MARK: - Delegate Protocols

protocol GameDetailDelegate {
    
    func gamesWereModified()
    
}

