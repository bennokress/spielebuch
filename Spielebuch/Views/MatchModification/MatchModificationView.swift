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
    
    // View Components
    private let cancelBarButtonItem = UIBarButtonItem()
    private let saveBarButtonItem = UIBarButtonItem()
    // ↓ Dummies to see the workflow … may be replaced later
    private let chooseDateButton = UIButton(type: .system)
    private let chosenDateLabel = UILabel()
    private let addScoreButton = UIButton(type: .system)
    private let scoresLabel = UILabel()
    
}

// MARK: - View Lifecycle

extension MatchModificationViewController {
    
    override func loadView() {
        super.loadView()
        initializeVIP()
        setupView()
        interpreter?.viewIsLoading(with: setupData)
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
        setupChosenDateLabel()
        setupChooseDateButton()
        setupAddScoreButton()
        setupScoresLabel()
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
        interpreter?.userTappedSaveMatchButton()
    }
    
    // MARK: Choose Date Dummy
    private func setupChooseDateButton() {
        chooseDateButton.titleLabel?.font = .systemFont(ofSize: chosenDateLabel.font.pointSize)
        chooseDateButton.addTarget(self, action: #selector(chooseDateButtonTapped), for: .touchUpInside)
        view.addSubview(chooseDateButton)
    }
    
    private func setupChosenDateLabel() {
        chosenDateLabel.text = "on " // Space necessary for natural spacing to chooseDateButton
        view.addSubview(chosenDateLabel)
    }
    
    @objc func chooseDateButtonTapped() {
        let randomDate = Date.randomInLastWeek // TODO: Replace with actual choice when implemented
        interpreter?.userChose(randomDate)
    }
    
    // MARK: Add Score Dummy
    private func setupAddScoreButton() {
        addScoreButton.setTitle("+ Add Random Scores", for: .normal)
        addScoreButton.titleLabel?.font = .systemFont(ofSize: chosenDateLabel.font.pointSize)
        addScoreButton.addTarget(self, action: #selector(addScoreButtonTapped), for: .touchUpInside)
        view.addSubview(addScoreButton)
    }
    
    private func setupScoresLabel() {
        scoresLabel.text = ""
        scoresLabel.numberOfLines = 0
        view.addSubview(scoresLabel)
    }
    
    @objc func addScoreButtonTapped() {
        // TODO: Should display fields for a new score (Player, ScoreComponents of the chosen Game)
        interpreter?.userTappedAddScoreButton()
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        chosenDateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        chosenDateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        chosenDateLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snpSafeArea.top)
            constraint.left.equalTo(snpSafeArea.left).offset(Margin.horizontal.standard)
            constraint.height.equalTo(50)
        }
        chooseDateButton.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(chosenDateLabel.snp.top)
            constraint.left.equalTo(chosenDateLabel.snp.right)
            constraint.bottom.equalTo(chosenDateLabel.snp.bottom)
        }
        addScoreButton.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(chosenDateLabel.snp.bottom).offset(Margin.vertical.standard)
            constraint.left.equalTo(snpSafeArea.left).offset(Margin.vertical.standard)
            constraint.right.equalTo(snpSafeArea.right).offset(Margin.vertical.inverseStandard)
            constraint.height.equalTo(50)
        }
        scoresLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(addScoreButton.snp.bottom).offset(Margin.vertical.standard)
            constraint.left.equalTo(snpSafeArea.left).offset(Margin.horizontal.standard)
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
    
    /// Removes the MatchModificationView.
    func dismiss()
    
    /// Sets the title of the view.
    /// - Parameter title: The title to be displayed.
    func setTitle(to title: String)
    
    /// Display the given date.
    /// - Parameter game: The date to be displayed.
    func set(_ date: Date)
    
    /// Display the given score.
    /// - Parameter score: The score to be displayed.
    func display(_ scores: [Score])
    
    /// Notifies all delegates about the modified match.
    /// - Parameter modifiedMatch: The modified match.
    func notifyDelegates(about modifiedMatch: Match)
    
    /// Disables the save button.
    func disableSaveButton()
    
    /// Enable the save button.
    func enableSaveButton()
    
}

extension MatchModificationViewController: MatchModificationView {
    
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
    
    func set(_ date: Date) {
        DispatchQueue.main.async {
            self.chooseDateButton.setTitle(date.shortDescription, for: .normal)
        }
    }
    
    func display(_ scores: [Score]) {
        var scoresInfo = ""
        for (rank, score) in scores.enumerated() {
            log.verbose("\(rank + 1).\t\(score.player.fullName) → \(score.value)")
            scoresInfo.appendLine("\(rank + 1).\t\(score.player.fullName)")
        }
        DispatchQueue.main.async {
            self.scoresLabel.text = scoresInfo
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
