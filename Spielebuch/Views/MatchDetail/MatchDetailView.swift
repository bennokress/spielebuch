//
//  MatchDetailView.swift
//  Spielebuch
//
//  Created by Benno Kress on 22.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import SnapKit
import UIKit

class MatchDetailViewController: VIPViewController {
    
    private var interpreter: MatchDetailInterpreter?
    var delegates: [MatchDetailDelegate] = []
    
    // Data
    private var match: Match? = nil
    
    // View Components
    private let editMatchBarButtonItem = UIBarButtonItem()
    private let gameNameLabel = UILabel()
    
}

// MARK: - View Lifecycle

extension MatchDetailViewController {
    
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

extension MatchDetailViewController {
    
    private func setupView() {
        view.backgroundColor = .background
        setupNavigationBar()
        setupGameNameLabel()
    }
    
    // MARK: Navigation Bar
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        editMatchBarButtonItem.title = "Edit"
        editMatchBarButtonItem.style = .plain
        editMatchBarButtonItem.target = self
        editMatchBarButtonItem.action = #selector(editMatch)
        
        navigationItem.rightBarButtonItem = editMatchBarButtonItem
    }
    
    @objc func editMatch() {
        interpreter?.userTappedEditButton(for: match)
    }
    
    // MARK: Match Details
    private func setupGameNameLabel() {
        gameNameLabel.text = match?.game.name
        view.addSubview(gameNameLabel)
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        gameNameLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snpSafeArea.top).offset(Margin.vertical.standard)
            constraint.left.equalTo(snpSafeArea.left).offset(Margin.horizontal.standard)
            constraint.right.equalTo(snpSafeArea.right).offset(Margin.horizontal.inverseStandard)
        }
    }
    
}

// MARK: - Private Helpers

extension MatchDetailViewController {
    
    
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

extension MatchDetailViewController {
    
    private func initializeVIP() {
        let presenter = MatchDetailPresenterImplementation(for: self as MatchDetailView)
        self.interpreter = MatchDetailInterpreterImplementation(with: presenter)
    }
    
}

// MARK: - MatchDetailView Protocol
// --> Every action provided to the Presenter

protocol MatchDetailView: class {
    
    /// Displays the details of the provided match.
    /// - Parameter match: The match to be displayed.
    func showDetails(of match: Match)
    
    /// Presents a prefilled MatchModificationView.
    /// - Parameter setupData: The data used to set up the MatchDetailView.
    func showEditMatchView(with setupData: VIPViewSetupData?)
    
    /// Notifies the delegates about modified matches.
    func notifyDelegatesAboutChange()
    
}

extension MatchDetailViewController: MatchDetailView {
    
    func showDetails(of match: Match) {
        self.match = match
        title = match.date.shortDescription
    }
    
    func showEditMatchView(with setupData: VIPViewSetupData?) {
        log.info("Match Modification View is not yet implemented")
//        let editMatchViewController = MatchModificationViewController()
//        editMatchViewController.delegates.append(self)
//        editMatchViewController.setup(with: setupData)
//        let editMatchNavigationController = UINavigationController(rootViewController: editMatchViewController)
//        present(editMatchNavigationController, animated: true)
    }
    
    func notifyDelegatesAboutChange() {
        delegates.forEach { $0.matchesWereModified() }
    }
    
}

// MARK: - SnapKit Helper

extension MatchDetailViewController {
    
    private var snpSafeArea: ConstraintLayoutGuideDSL { return self.view.safeAreaLayoutGuide.snp }
    private var snpNavigationBar: ConstraintViewDSL { return self.navigationController!.navigationBar.snp }
    
}

// MARK: - Delegate Implementations

//extension MatchDetailViewController: MatchModificationDelegate {
//    
//    func matchDetailChanged(for match: Match) {
//        interpreter?.delegateReceived(match)
//    }
//    
//}

// MARK: - Delegate Protocols

protocol MatchDetailDelegate {
    
    func matchesWereModified()
    
}
