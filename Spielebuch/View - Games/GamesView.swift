//
//  GamesView.swift
//  Spielebuch
//
//  Created by Benno Kress on 29.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import SnapKit
import UIKit

class GamesViewController: VIPViewController {
    
    private var interpreter: GamesInterpreter?
    private let gamesTableView = UITableView()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var games: [Game] = []
    
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
    
    private func setupView() {
        view.backgroundColor = .white
        setupGamesTableView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.title = "Games"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        let addBarButtonItem = setupNavigationItem(withUIImageNamed: "NavigationBarItem-Add", andAction: #selector(addItem))
        let searchBarButtonItem = setupNavigationItem(withUIImageNamed: "NavigationBarItem-Search", andAction: #selector(searchItems))
        self.navigationItem.rightBarButtonItems = [addBarButtonItem, searchBarButtonItem]
        
    }
    
    private func setupNavigationItem(withUIImageNamed assetName: String, andAction action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: UIImage(named: assetName), style: .plain, target: self, action: action)
        item.tintColor = .black
        item.width = 24
        return item
    }
    
    private func setupGamesTableView() {
        view.addSubview(gamesTableView)
        
        gamesTableView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view)
        }
        
        gamesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "gameCell")
        gamesTableView.dataSource = self
        gamesTableView.tableHeaderView = searchController.searchBar
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
    
    /// Set the games to be displayed
    func updateGames(from newGamesList: [Game])
    
}

// MARK: - GamesView Conformance
extension GamesViewController: GamesView {
    
    func updateGames(from newGamesList: [Game]) {
        self.games = newGamesList
    }
    
}

// MARK: - UITableViewDataSource Conformance
extension GamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        gameCell.textLabel?.text = games[indexPath.row].name
        return gameCell
    }
    
}

extension GamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log.info("Games Table Row \(indexPath.row) tapped")
        // TODO: Implement and link GameDetailViewController
        // let gameDetailViewController = GameDetailViewController()
        // self.navigationController?.pushViewController(profileViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Bar Button Items
extension GamesViewController {
    
    @objc func addItem() {
        log.info("Add Game Button tapped")
        // TODO: Implement and link AddGameViewController
        // let addGameViewController = AddGameViewController()
        // let navigationController = UINavigationController(rootViewController: addViewController)
        // self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func searchItems() {
        searchController.searchBar.becomeFirstResponder()
    }
    
}
