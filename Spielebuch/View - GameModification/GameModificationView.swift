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
    var delegate: GameModificationDelegate? = nil
    
    let nameTextField = UITextField()
    let cancelBarButtonItem = UIBarButtonItem()
    let saveBarButtonItem = UIBarButtonItem()
    
    private var game: Game? = nil
    private var isInEditMode: Bool { return game != nil }
    
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
    
    // MARK: - Setup
    
    // MARK: View
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
    
    // MARK: Name Text Field
    private func setupNameTextField() {
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Name"
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
    
    // MARK: - VIP Cycle
    
    /// Initializes corresponding Interpreter and Presenter
    private func initializeVIP() {
        let presenter = GameModificationPresenterImplementation(for: self as GameModificationView)
        self.interpreter = GameModificationInterpreterImplementation(with: presenter)
    }
    
    /// Unwind Segue Setup
    @IBAction func unwindToGameModificationView(sender: UIStoryboardSegue) {
        VIPSegue.unwindToGameModification.prepare(from: sender, to: self as VIPViewController)
    }
    
}

// MARK: - Bar Button Items
extension GameModificationViewController {
    
    @objc func cancelModification() {
        interpreter?.userTappedCancelButton()
    }
    
    @objc func saveGame() {
        // TODO: Replace Dummy by making sure save can't be tapped without filled fields.
        interpreter?.userTappedSaveGameButton(name: nameTextField.text, for: game)
    }
    
}

// MARK: - GameModificationView Protocol
protocol GameModificationView: class {
    
    /// Makes the method from the superclass VIPViewController visible in order to pass data to a segue destination view controller.
    func setPassOnData(to passOnData: VIPViewSetupData?)
    
    /// Normally used to display the value, but used in console for demonstration purposes here.
    func fillFieldsWithCurrentValues(of game: Game)
    
    /// Removes the GameModificationView.
    func dismiss()
    
    func setTitle(to title: String)
    
    func notifyDelegate(about modifiedGame: Game)
    
    func disableSaveButton()
    
    func enableSaveButton()
    
}

// MARK: - GameModificationView Conformance
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
    
    func notifyDelegate(about modifiedGame: Game) {
        delegate?.gameDetailChanged(for: modifiedGame)
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

// MARK: - GameModificationDelegate
protocol GameModificationDelegate {
    func gameDetailChanged(for game: Game)
}

