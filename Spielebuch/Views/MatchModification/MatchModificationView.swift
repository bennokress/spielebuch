//
//  MatchModificationView.swift
//  Spielebuch
//
//  Created by Benno Kress on 24.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import SnapKit
import UIKit

class MatchModificationViewController: VIPViewController {
    
    private var interpreter: MatchModificationInterpreter?
    var delegates: [MatchModificationDelegate] = []
    
    // Data
    private var match: Match? = nil
    private var isInEditMode: Bool { return match != nil }
    
    // View Components
    private let cancelBarButtonItem = UIBarButtonItem()
    private let saveBarButtonItem = UIBarButtonItem()
    // ↓ Dummies to see the workflow … will be replaced later
    private let chooseGameDummyButton = UIButton(type: .system)
    private let chosenGameDummyLabel = UILabel()
    
}

// MARK: - View Lifecycle

extension MatchModificationViewController {
    
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

extension MatchModificationViewController {
    
    private func setupView() {
        view.backgroundColor = .background
        setupNavigationBar()
        setupChooseGameDummyButton()
        setupChosenGameDummyLabel()
    }
    
    // MARK: Navigation Bar
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        cancelBarButtonItem.title = "Cancel"
        cancelBarButtonItem.style = .plain
        cancelBarButtonItem.target = self
        cancelBarButtonItem.action = #selector(cancelModification)
        
        saveBarButtonItem.title = "Save"
        saveBarButtonItem.style = .done
        saveBarButtonItem.target = self
        saveBarButtonItem.action = #selector(saveMatch)
        
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = saveBarButtonItem
        
        disableSaveButton()
    }
    
    @objc func cancelModification() {
        interpreter?.userTappedCancelButton()
    }
    
    @objc func saveMatch() {
        log.warning("Saving a new match of a dummy game")
        let dummyGame = Game(named: "Dummy")
        interpreter?.userTappedSaveMatchButton(game: dummyGame, on: Date(), for: nil)
    }
    
    // MARK: Choose Game Dummy
    private func setupChooseGameDummyButton() {
        chooseGameDummyButton.setTitle("Choose Game", for: .normal)
        chooseGameDummyButton.addTarget(self, action: #selector(chooseGameButtonTapped), for: .touchUpInside)
        view.addSubview(chooseGameDummyButton)
    }
    
    private func setupChosenGameDummyLabel() {
        chosenGameDummyLabel.text = ""
        view.addSubview(chosenGameDummyLabel)
    }
    
    @objc func chooseGameButtonTapped() {
//        interpreter?.userTappedDummyChooseGameButton()
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        chooseGameDummyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        chooseGameDummyButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        chooseGameDummyButton.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snpSafeArea.top).offset(Margin.vertical.standard)
            constraint.left.equalTo(snpSafeArea.left).offset(Margin.horizontal.standard)
            constraint.height.equalTo(50)
        }
        chosenGameDummyLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(chooseGameDummyButton.snp.top)
            constraint.left.equalTo(chooseGameDummyButton.snp.right).offset(Margin.horizontal.standard)
            constraint.bottom.equalTo(chooseGameDummyButton.snp.bottom)
            constraint.right.equalTo(snpSafeArea.right).offset(Margin.horizontal.inverseStandard)
        }
    }
    
}

// MARK: - Private Helpers

extension MatchModificationViewController {
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

extension MatchModificationViewController {
    
    private func initializeVIP() {
        let presenter = MatchModificationPresenterImplementation(for: self as MatchModificationView)
        self.interpreter = MatchModificationInterpreterImplementation(with: presenter)
    }
    
}

// MARK: - MatchModificationView Protocol
// --> Every action provided to the Presenter

protocol MatchModificationView: class {
    
    /// Fills in the details for the match that is being modified.
    /// - Parameter match: The match to be modified.
    func fillFieldsWithCurrentValues(of match: Match)
    
    /// Removes the MatchModificationView.
    func dismiss()
    
    /// Sets the title of the view.
    /// - Parameter title: The title to be displayed.
    func setTitle(to title: String)
    
    /// Notifies all delegates about the modified match.
    /// - Parameter modifiedMatch: The modified match.
    func notifyDelegates(about modifiedMatch: Match)
    
    /// Disables the save button.
    func disableSaveButton()
    
    /// Enable the save button.
    func enableSaveButton()
    
    /// Display the given game.
    /// - Parameter game: The game to be displayed.
    func set(_ game: Game)
    
}

extension MatchModificationViewController: MatchModificationView {
    
    func fillFieldsWithCurrentValues(of match: Match) {
        self.match = match
        set(match.game)
        log.info("Would fill some field for a match of \(match.game.name) on \(match.date.shortDescription).")
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true)
        }
    }
    
    func setTitle(to title: String) {
        DispatchQueue.main.async {
            self.title = title
        }
    }
    
    func notifyDelegates(about modifiedMatch: Match) {
        delegates.forEach { $0.matchDetailChanged(for: modifiedMatch) }
    }
    
    func disableSaveButton() {
        DispatchQueue.main.async {
            self.saveBarButtonItem.isEnabled = false
        }
    }
    
    func enableSaveButton() {
        DispatchQueue.main.async {
            self.saveBarButtonItem.isEnabled = true
        }
    }
    
    func set(_ game: Game) {
        DispatchQueue.main.async {
            self.chosenGameDummyLabel.text = game.name
        }
    }
    
}

// MARK: - SnapKit Helper
extension MatchModificationViewController {
    
    private var snpSafeArea: ConstraintLayoutGuideDSL { return self.view.safeAreaLayoutGuide.snp }
    private var snpNavigationBar: ConstraintViewDSL { return self.navigationController!.navigationBar.snp }
    
}

// MARK: - Delegate Implementations



// MARK: - Delegate Protocols

protocol MatchModificationDelegate {
    
    func matchDetailChanged(for modified: Match)
    
}
