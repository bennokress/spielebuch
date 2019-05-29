//
//  GamesView.swift
//  Spielebuch
//
//  Created by Benno Kress on 29.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit
import SnapKit

class GamesViewController: VIPViewController {
    
    private var interpreter: GamesInterpreter?
    private let gamesTableView = UITableView()
    
    private let games = ["Azul", "Rommé", "Istanbul", "Texas Hold'Em Poker"]
    
    override func loadView() {
        super.loadView()
        initializeVIP()
        self.title = "Games"
        view.backgroundColor = .white
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
    
    private func setupView() {
        setupGamesTableView()
    }
    
    private func setupGamesTableView() {
        view.addSubview(gamesTableView)
        
        gamesTableView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view)
        }
        
        gamesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "gameCell")
        gamesTableView.dataSource = self
    }
    
    // MARK: 📱 Presentation Layer Cycle (View - Interpreter - Presenter)
    
    /// Initializes corresponding Interpreter and Presenter
    private func initializeVIP() {
        let presenter = GamesPresenterImplementation(for: self as GamesView)
        self.interpreter = GamesInterpreterImplementation(with: presenter)
    }
    
    /// Unwind Segue Setup
    @IBAction func unwindToGamesView(sender: UIStoryboardSegue) {
        VIPSegue.unwindToGames.prepare(from: sender, to: self as VIPViewController)
    }
    
}

// MARK: - GamesView Protocol
protocol GamesView: class {
    
    /// Makes the method from the superclass VIPViewController visible in order to pass data to a segue destination view controller.
    func setPassOnData(to passOnData: VIPViewSetupData?)
    
    /// Normally used to display the value, but used in console for demonstration purposes here.
    func doSomething(with someBoolValue: Bool)
    
}

// MARK: - GamesView Conformance
extension GamesViewController: GamesView {
    
    func doSomething(with someBoolValue: Bool) {
        print(someBoolValue ? "yup" : "nope")
    }
    
}

// MARK: - UITableViewDataSource Conformance
extension GamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        gameCell.textLabel?.text = games[indexPath.row]
        return gameCell
    }
    
}
