//
//  GameModificationView.swift
//  Spielebuch
//
//  Created by Benno Kress on 11.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

class GameModificationViewController: VIPViewController {
    
    private var interpreter: GameModificationInterpreter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVIP()
        // Do any additional setup after loading the view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interpreter?.viewWillAppear(with: setupData)
    }
    
    // MARK: 📱 Presentation Layer Cycle (View - Interpreter - Presenter)
    
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

// MARK: - GameModificationView Protocol
protocol GameModificationView: class {
    
    /// Makes the method from the superclass VIPViewController visible in order to pass data to a segue destination view controller.
    func setPassOnData(to passOnData: VIPViewSetupData?)
    
    /// Normally used to display the value, but used in console for demonstration purposes here.
    func fillFieldsWithCurrentValues(of game: Game)
    
}

// MARK: - GameModificationView Conformance
extension GameModificationViewController: GameModificationView {
    
    func fillFieldsWithCurrentValues(of game: Game) {
        log.info("Filling fields for \(game.name)")
    }
    
}

