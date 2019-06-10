//
//  GameDetailView.swift
//  Spielebuch
//
//  Created by Benno Kress on 10.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

class GameDetailViewController: VIPViewController {
    
    // FIXME: Add normal segues from this ViewController to VIPSegue
    
    private var interpreter: GameDetailInterpreter?
    
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
        let presenter = GameDetailPresenterImplementation(for: self as GameDetailView)
        self.interpreter = GameDetailInterpreterImplementation(with: presenter)
    }
    
    /// Unwind Segue Setup
    @IBAction func unwindToGameDetailView(sender: UIStoryboardSegue) {
        VIPSegue.unwindToGameDetail.prepare(from: sender, to: self as VIPViewController)
    }
    
}

// MARK: - GameDetailView Protocol
protocol GameDetailView: class {
    
    /// Makes the method from the superclass VIPViewController visible in order to pass data to a segue destination view controller.
    func setPassOnData(to passOnData: VIPViewSetupData?)
    
    /// Normally used to display the value, but used in console for demonstration purposes here.
    func showDetails(of game: Game)
    
}

// MARK: - GameDetailView Conformance
extension GameDetailViewController: GameDetailView {
    
    func showDetails(of game: Game) {
        print(game.name)
    }
    
}

