//
//  GameDetailView.swift
//  Spielebuch
//
//  Created by Benno Kress on 10.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

class GameDetailViewController: VIPViewController {
    
    private var interpreter: GameDetailInterpreter?
    
    override func loadView() {
        super.loadView()
        initializeVIP()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interpreter?.viewWillAppear(with: setupData)
    }
    
    // MARK: - Setup
    
    // MARK: View
    private func setupView() {
        view.backgroundColor = .white
    }
    
    // MARK: - VIP Cycle
    
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
        log.verbose("Showing details of the game named \"\(game.name)\"")
    }
    
}

