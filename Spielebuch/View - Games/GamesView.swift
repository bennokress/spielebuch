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
    
    private var groupedGames: [String: [Game]] = [:]
    private var sections: [String] { return groupedGames.keys.sorted { $0 < $1 } }
    
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
        setupGamesTableView()
        setupNavigationBar()
        setupSearchController()
    }
    
    // MARK: Search Controller
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Games"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: Navigation Bar
    private func setupNavigationBar() {
        title = "Games"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let addBarButtonItem = setupNavigationItem(withUIImageNamed: "NavigationBarItem-Add", andAction: #selector(addItem))
        let searchBarButtonItem = setupNavigationItem(withUIImageNamed: "NavigationBarItem-Search", andAction: #selector(searchItems))
        navigationItem.rightBarButtonItem = addBarButtonItem
        navigationItem.leftBarButtonItem = searchBarButtonItem
    }
    
    // MARK: Navigation Items
    private func setupNavigationItem(withUIImageNamed assetName: String, andAction action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: UIImage(named: assetName), style: .plain, target: self, action: action)
        item.tintColor = .black
        item.width = 24
        return item
    }
    
    // MARK: Games Table View
    private func setupGamesTableView() {
        view.addSubview(gamesTableView)
        
        gamesTableView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view)
        }
        
        gamesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "gameCell")
        gamesTableView.dataSource = self
        gamesTableView.delegate = self
    }
    
    // MARK: - VIP Cycle
    
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
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
    
}

// MARK: - Protocol Conformances

// MARK: GamesView

protocol GamesView: class {
    
    /// Makes the method from the superclass VIPViewController visible in order to pass data to a segue destination view controller.
    func setPassOnData(to passOnData: VIPViewSetupData?)
    
    /// Set the games to be displayed
    func updateGames(from groupedGames: [String: [Game]])
    
}

extension GamesViewController: GamesView {
    
    func updateGames(from groupedGames: [String: [Game]]) {
        self.groupedGames = groupedGames
        reloadGamesTableViewData()
    }
    
}

// MARK: UITableViewDataSource
extension GamesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sections[section]
        guard let gameCountForSection = groupedGames[sectionTitle]?.count else {
            log.error("Error while searching for Games in Section \"\(sectionTitle)\"")
            fatalError()
        }
        return gameCountForSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionTitle = sections[indexPath.section]
        guard let sectionGames = groupedGames[sectionTitle] else {
            log.error("Error while searching for Games in Section \"\(sectionTitle)\"")
            fatalError()
        }
        let game = sectionGames[indexPath.row]
        
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        gameCell.textLabel?.text = game.name
        gameCell.accessoryType = .disclosureIndicator
        return gameCell
    }
    
}

// MARK: UITableViewDelegate
extension GamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let firstLetter = sections[indexPath.section]
        let game = groupedGames[firstLetter]?[indexPath.row]
        log.info("Games Table Row \(indexPath.section):\(indexPath.row) tapped: \(game?.name ?? "Unknown Game!")")
        
        // TODO: Implement and link GameDetailViewController
        // let gameDetailViewController = GameDetailViewController()
        // self.navigationController?.pushViewController(profileViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: UISearchResultsUpdating
extension GamesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchTerm = searchController.searchBar.text else {
            log.error("It seems like a search text was typed, but could not be retrieved.")
            return
        }
        interpreter?.userSearches(for: searchTerm)
    }
    
}
