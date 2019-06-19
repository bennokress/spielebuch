//
//  PlayerModificationView.swift
//  Spielebuch
//
//  Created by Benno Kress on 17.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import SnapKit
import UIKit

class PlayerModificationViewController: VIPViewController {
    
    private var interpreter: PlayerModificationInterpreter?
    var delegates: [PlayerModificationDelegate] = []
    
    // Data
    private var player: Player? = nil
    private var isInEditMode: Bool { return player != nil }
    
    // View Components
    private let cancelBarButtonItem = UIBarButtonItem()
    private let saveBarButtonItem = UIBarButtonItem()
    private let firstNameTextField = UITextField()
    private let lastNameTextField = UITextField()
    private let nicknameTextField = UITextField()
    
}

// MARK: - View Lifecycle

extension PlayerModificationViewController {
    
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

extension PlayerModificationViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupTextFields()
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
        saveBarButtonItem.action = #selector(savePlayer)
        
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = saveBarButtonItem
        
        disableSaveButton()
    }
    
    @objc func cancelModification() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        nicknameTextField.resignFirstResponder()
        interpreter?.userTappedCancelButton()
    }
    
    @objc func savePlayer() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        nicknameTextField.resignFirstResponder()
        interpreter?.userTappedSavePlayerButton(firstName: firstNameTextField.text, lastName: lastNameTextField.text, nickname: nicknameTextField.text, for: player)
    }
    
    // MARK: Text Fields
    private func setupTextFields() {
        setup(firstNameTextField, placeholder: "First Name", returnKeyType: .next, editingChangedAction: #selector(nameTextFieldDidChange))
        setup(lastNameTextField, placeholder: "Last Name", returnKeyType: .next, editingChangedAction: #selector(nameTextFieldDidChange))
        setup(nicknameTextField, placeholder: "Nickname (optional)", returnKeyType: .done, editingChangedAction: #selector(nameTextFieldDidChange))
    }
    
    private func setup(_ textField: UITextField, placeholder: String, returnKeyType: UIReturnKeyType, editingChangedAction: Selector) {
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.returnKeyType = returnKeyType
        textField.delegate = self
        textField.addTarget(self, action: editingChangedAction, for: .editingChanged)
        view.addSubview(textField)
    }
    
    @objc private func nameTextFieldDidChange() {
        interpreter?.userEditedTextFields(to: firstNameTextField.text, lastNameTextField.text, nicknameTextField.text, for: player)
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        firstNameTextField.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snpSafeArea.top).offset(Margin.vertical.standard)
            constraint.left.equalTo(snpSafeArea.left).offset(Margin.horizontal.standard)
            constraint.right.equalTo(snpSafeArea.right).offset(Margin.horizontal.inverseStandard)
            constraint.height.equalTo(50)
        }
        lastNameTextField.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(firstNameTextField.snp.bottom).offset(Margin.vertical.standard)
            constraint.left.equalTo(snpSafeArea.left).offset(Margin.horizontal.standard)
            constraint.right.equalTo(snpSafeArea.right).offset(Margin.horizontal.inverseStandard)
            constraint.height.equalTo(50)
        }
        nicknameTextField.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(lastNameTextField.snp.bottom).offset(Margin.vertical.standard)
            constraint.left.equalTo(snpSafeArea.left).offset(Margin.horizontal.standard)
            constraint.right.equalTo(snpSafeArea.right).offset(Margin.horizontal.inverseStandard)
            constraint.height.equalTo(50)
        }
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

extension PlayerModificationViewController {
    
    private func initializeVIP() {
        let presenter = PlayerModificationPresenterImplementation(for: self as PlayerModificationView)
        self.interpreter = PlayerModificationInterpreterImplementation(with: presenter)
    }
    
}

// MARK: View Protocol
// --> Every action provided to the Presenter

protocol PlayerModificationView: class {
    
    /// Fills in the details for the player that is being modified.
    /// - Parameter player: The player to be modified.
    func fillFieldsWithCurrentValues(of player: Player)
    
    /// Removes the PlayerModificationView.
    func dismiss()
    
    /// Sets the title of the view.
    /// - Parameter title: The title to be displayed.
    func setTitle(to title: String)
    
    /// Notifies all delegates about the modified player.
    /// - Parameter modifiedPlayer: The modified player.
    func notifyDelegates(about modifiedPlayer: Player)
    
    /// Disables the save button.
    func disableSaveButton()
    
    /// Enable the save button.
    func enableSaveButton()
    
}

extension PlayerModificationViewController: PlayerModificationView {
    
    func fillFieldsWithCurrentValues(of player: Player) {
        self.player = player
        firstNameTextField.text = player.firstName
        lastNameTextField.text = player.lastName
        nicknameTextField.text = player.nickname
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
    
    func notifyDelegates(about modifiedPlayer: Player) {
        delegates.forEach { $0.playerDetailChanged(for: modifiedPlayer) }
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

extension PlayerModificationViewController {
    
    private var snpSafeArea: ConstraintLayoutGuideDSL { return self.view.safeAreaLayoutGuide.snp }
    private var snpNavigationBar: ConstraintViewDSL { return self.navigationController!.navigationBar.snp }
    
}

// MARK: - Delegate Implementations

extension PlayerModificationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - Delegate Protocols

protocol PlayerModificationDelegate {
    
    func playerDetailChanged(for modified: Player)
    
}
