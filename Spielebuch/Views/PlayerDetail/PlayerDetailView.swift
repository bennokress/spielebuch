//
//  PlayerDetailView.swift
//  Spielebuch
//
//  Created by Benno Kress on 17.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import SnapKit
import UIKit

class PlayerDetailViewController: VIPViewController {
    
    private var interpreter: PlayerDetailInterpreter?
    var delegates: [PlayerDetailDelegate] = []
    
    // Data
    private var player: Player? = nil
    
    // View Components
    private let editPlayerBarButtonItem = UIBarButtonItem()
    private let fullNameLabel = UILabel()
    
}

// MARK: - View Lifecycle

extension PlayerDetailViewController {
    
    override func loadView() {
        super.loadView()
        initializeVIP()
        interpreter?.viewIsLoading(with: setupData)
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
}

// MARK: - View Setup

extension PlayerDetailViewController {
    
    private func setupView() {
        view.backgroundColor = .background
        setupNavigationBar()
        setupFullNameLabel()
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
    
    // MARK: Player Details
    private func setupFullNameLabel() {
        fullNameLabel.text = player?.fullName
        view.addSubview(fullNameLabel)
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        fullNameLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snpSafeArea.top).offset(Margin.vertical.standard)
            constraint.left.equalTo(snpSafeArea.left).offset(Margin.horizontal.standard)
            constraint.right.equalTo(snpSafeArea.right).offset(Margin.horizontal.inverseStandard)
        }
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
        let editPlayerViewController = PlayerModificationViewController()
        editPlayerViewController.delegates.append(self)
        editPlayerViewController.setup(with: setupData)
        let editPlayerNavigationController = UINavigationController(rootViewController: editPlayerViewController)
        present(editPlayerNavigationController, animated: true)
    }
    
    func notifyDelegatesAboutChange() {
        delegates.forEach { $0.playersWereModified() }
    }
    
}

// MARK: - SnapKit Helper

extension PlayerDetailViewController {
    
    private var snpSafeArea: ConstraintLayoutGuideDSL { return self.view.safeAreaLayoutGuide.snp }
    private var snpNavigationBar: ConstraintViewDSL { return self.navigationController!.navigationBar.snp }
    
}

// MARK: - Delegate Implementations

extension PlayerDetailViewController: PlayerModificationDelegate {

    func playerDetailChanged(for player: Player) {
        interpreter?.delegateReceived(player)
    }

}

// MARK: - Delegate Protocols

protocol PlayerDetailDelegate {
    
    func playersWereModified()
    
}
