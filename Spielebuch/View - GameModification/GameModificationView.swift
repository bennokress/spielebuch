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
    
    let nameTextField = UITextField()
    
    private var game: Game? = nil
    
    override func loadView() {
        super.loadView()
        initializeVIP()
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
        setupNameLabel()
    }
    
    // MARK: Navigation Bar
    private func setupNavigationBar() {
        title = "New Game"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelModification))
        let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveGame))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    // MARK: Name Label
    private func setupNameLabel() {
        nameTextField.backgroundColor = .red
        view.addSubview(nameTextField)
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
        interpreter?.userTappedSaveGameButton(name: nameTextField.text ?? "Dummy")
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
    
}

// MARK: - GameModificationView Conformance
extension GameModificationViewController: GameModificationView {
    
    func fillFieldsWithCurrentValues(of game: Game) {
        log.info("Filling fields for \(game.name)")
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true)
        }
    }
    
}

// MARK: - SnapKit Helper
extension GameModificationViewController {
    private var snpSafeArea: ConstraintLayoutGuideDSL { return self.view.safeAreaLayoutGuide.snp }
    private var snpNavigationBar: ConstraintViewDSL { return self.navigationController!.navigationBar.snp }
}

