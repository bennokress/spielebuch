//
//  PlayerDetailView.swift
//  Spielebuch
//
//  Created by Benno Kress on 17.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

class PlayerDetailViewController: VIPViewController {
    
    private var interpreter: PlayerDetailInterpreter?
    var delegates: [PlayerDetailDelegate] = []
    
    // Data
    private var player: Player? = nil
    
    // View Components
    private let editPlayerBarButtonItem = UIBarButtonItem()
    
}

// MARK: - View Lifecycle

extension PlayerDetailViewController {
    
    override func loadView() {
        super.loadView()
        initializeVIP()
        interpreter?.viewIsLoading(with: setupData)
        setupView()
    }
    
}

// MARK: - View Setup

extension PlayerDetailViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    // MARK: Navigation Bar
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        editPlayerBarButtonItem.title = "Edit"
        editPlayerBarButtonItem.style = .plain
        editPlayerBarButtonItem.target = self
        editPlayerBarButtonItem.action = #selector(editPlayer)
        
        navigationItem.rightBarButtonItem = editPlayerBarButtonItem
    }
    
    @objc func editPlayer() {
        interpreter?.userTappedEditButton(for: player)
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

extension PlayerDetailViewController {
    
    private func initializeVIP() {
        let presenter = PlayerDetailPresenterImplementation(for: self as PlayerDetailView)
        self.interpreter = PlayerDetailInterpreterImplementation(with: presenter)
    }
    
}

// MARK: View Protocol
// --> Every action provided to the Presenter

protocol PlayerDetailView: class {
    
    /// Displays the details of the provided player.
    /// - Parameter player: The player to be displayed.
    func showDetails(of player: Player)
    
    /// Presents a prefilled PlayerModificationView.
    /// - Parameter setupData: The data used to set up the PlayerDetailView.
    func showEditPlayerView(with setupData: VIPViewSetupData?)
    
    /// Notifies the delegates about modified players.
    func notifyDelegatesAboutChange()
    
}

extension PlayerDetailViewController: PlayerDetailView {
    
    func showDetails(of player: Player) {
        self.player = player
        title = player.displayname
    }
    
    func showEditPlayerView(with setupData: VIPViewSetupData?) {
        log.info("Edit Player View was requested")
//        let editPlayerViewController = PlayerModificationViewController()
//        editPlayerViewController.delegates.append(self)
//        editPlayerViewController.setup(with: setupData)
//        let editPlayerNavigationController = UINavigationController(rootViewController: editPlayerViewController)
//        present(editPlayerNavigationController, animated: true)
    }
    
    func notifyDelegatesAboutChange() {
        delegates.forEach { $0.playersWereModified() }
    }
    
}

// MARK: - Delegate Implementations

//extension PlayerDetailViewController: PlayerModificationDelegate {
//
//    func playerDetailChanged(for player: Player) {
//        interpreter?.delegateReceived(player)
//    }
//
//}

// MARK: - Delegate Protocols

protocol PlayerDetailDelegate {
    
    func playersWereModified()
    
}
