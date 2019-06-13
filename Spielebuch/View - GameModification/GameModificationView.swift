//
//  GameModificationView.swift
//  Spielebuch
//
//  Created by Benno Kress on 11.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import SnapKit
import UIKit

class GameModificationViewController: VIPViewController {
    
    private var interpreter: GameModificationInterpreter?
    var delegates: [GameModificationDelegate] = []
    
    // Data
    private var game: Game? = nil
    private var isInEditMode: Bool { return game != nil }
    
    // View Components
    private let cancelBarButtonItem = UIBarButtonItem()
    private let saveBarButtonItem = UIBarButtonItem()
    private let nameTextField = UITextField()
    
}

// MARK: - View Lifecycle

extension GameModificationViewController {
    
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

extension GameModificationViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupNameTextField()
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
        saveBarButtonItem.action = #selector(saveGame)
        
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = saveBarButtonItem
        
        disableSaveButton()
    }
    
    @objc func cancelModification() {
        nameTextField.resignFirstResponder()
        interpreter?.userTappedCancelButton()
    }
    
    @objc func saveGame() {
        nameTextField.resignFirstResponder()
        interpreter?.userTappedSaveGameButton(name: nameTextField.text, for: game)
    }
    
    // MARK: Name Text Field
    private func setupNameTextField() {
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Name"
        nameTextField.returnKeyType = UIReturnKeyType.done
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        view.addSubview(nameTextField)
    }
    
    @objc private func nameTextFieldDidChange() {
        interpreter?.userEditedNameTextField(to: nameTextField.text, for: game)
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        nameTextField.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snpSafeArea.top).offset(Margin.vertical.standard)
            constraint.left.equalTo(snpSafeArea.left).offset(Margin.horizontal.standard)
            constraint.right.equalTo(snpSafeArea.right).offset(Margin.horizontal.inverseStandard)
            constraint.height.equalTo(50)
        }
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

extension GameModificationViewController {
    
    private func initializeVIP() {
        let presenter = GameModificationPresenterImplementation(for: self as GameModificationView)
        self.interpreter = GameModificationInterpreterImplementation(with: presenter)
    }
    
}

// MARK: View Protocol
// --> Every action provided to the Presenter

protocol GameModificationView: class {
    
    /// Fills in the details for the game that is being modified.
    /// - Parameter game: The game to be modified.
    func fillFieldsWithCurrentValues(of game: Game)
    
    /// Removes the GameModificationView.
    func dismiss()
    
    /// Sets the title of the view.
    /// - Parameter title: The title to be displayed.
    func setTitle(to title: String)
    
    /// Notifies all delegates about the modified game.
    /// - Parameter modifiedGame: The modified game.
    func notifyDelegates(about modifiedGame: Game)
    
    /// Disables the save button.
    func disableSaveButton()
    
    /// Enable the save button.
    func enableSaveButton()
    
}

extension GameModificationViewController: GameModificationView {
    
    func fillFieldsWithCurrentValues(of game: Game) {
        self.game = game
        nameTextField.text = game.name
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true)
        }
    }
    
    func setTitle(to title: String) {
        self.title = title
    }
    
    func notifyDelegates(about modifiedGame: Game) {
        delegates.forEach { $0.gameDetailChanged(for: modifiedGame) }
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
extension GameModificationViewController {
    
    private var snpSafeArea: ConstraintLayoutGuideDSL { return self.view.safeAreaLayoutGuide.snp }
    private var snpNavigationBar: ConstraintViewDSL { return self.navigationController!.navigationBar.snp }
    
}

extension GameModificationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - Delegate Protocols

protocol GameModificationDelegate {
    
    func gameDetailChanged(for modified: Game)
    
}

