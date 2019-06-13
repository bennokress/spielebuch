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
    
    // Data
    private var groupedGames: [String: [Game]] = [:]
    
    // View Components
    private let gamesTableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    // View State
    private var sections: [String] { return groupedGames.keys.sorted { $0 < $1 } }
    private var isSearchActive = false
    
}

// MARK: - View Lifecycle

extension GamesViewController {
    
    override func loadView() {
        super.loadView()
        initializeVIP()
        setupView()
        interpreter?.viewIsLoading(with: setupData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
}

// MARK: - View Setup

extension GamesViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        setupGamesTableView()
        setupNavigationBar()
        setupSearchController()
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
    
    private func setupNavigationItem(withUIImageNamed assetName: String, andAction action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: UIImage(named: assetName), style: .plain, target: self, action: action)
        item.tintColor = .black
        item.width = 24
        return item
    }
    
    @objc func addItem() {
        interpreter?.userTappedAddGameButton()
    }
    
    @objc func searchItems() {
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
    
    // MARK: Search Controller
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Games"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: Games Table View
    private func setupGamesTableView() {
        gamesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "gameCell")
        gamesTableView.dataSource = self
        gamesTableView.delegate = self
        view.addSubview(gamesTableView)
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        gamesTableView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view)
        }
    }
    
    private func reloadGamesTableViewData() {
        DispatchQueue.main.async {
            self.gamesTableView.reloadData()
        }
    }
    
    private func push(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

extension GamesViewController {
    
    private func initializeVIP() {
        let presenter = GamesPresenterImplementation(for: self as GamesView)
        self.interpreter = GamesInterpreterImplementation(with: presenter)
    }
    
}

// MARK: View Protocol
// --> Every action provided to the Presenter

protocol GamesView: class {
    
    /// Replaces the currently displayed games by the ones provided.
    /// - Parameter groupedGames: The games to be displayed.
    func updateGames(from groupedGames: [String: [Game]])
    
    /// Presents a GameDetailView with the provided Data.
    /// - Parameter setupData: The data used to set up the GameDetailView.
    func showGameDetailView(with setupData: VIPViewSetupData)
    
    /// Presents an empty GameModificationView.
    func showNewGameView()
    
    /// Dismisses the search controller.
    func dismissSearchController()
    
}

extension GamesViewController: GamesView {
    
    func updateGames(from groupedGames: [String: [Game]]) {
        self.groupedGames = groupedGames
        reloadGamesTableViewData()
    }
    
    func showGameDetailView(with setupData: VIPViewSetupData) {
        let gameDetailViewController = GameDetailViewController()
        gameDetailViewController.delegates.append(self)
        gameDetailViewController.setup(with: setupData)
        push(gameDetailViewController)
    }
    
    func showNewGameView() {
        let newGameViewController = GameModificationViewController()
        newGameViewController.delegates.append(self)
        let newGameNavigationController = UINavigationController(rootViewController: newGameViewController)
        present(newGameNavigationController, animated: true)
    }
    
    func dismissSearchController() {
        isSearchActive = false
        DispatchQueue.main.async {
            self.navigationItem.searchController?.searchBar.text = ""
            self.navigationItem.searchController?.searchBar.resignFirstResponder()
            self.navigationItem.searchController?.isActive = false
        }
    }
    
}

// MARK: - Data Source Implementations

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

// MARK: - Delegate Implementations

extension GamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let firstLetter = sections[indexPath.section]
        let game = groupedGames[firstLetter]![indexPath.row]
        
        if isSearchActive {
            interpreter?.userTappedSearched(game)
        } else {
            interpreter?.userTapped(game)
        }
        
        DispatchQueue.main.async {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

extension GamesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        isSearchActive = true
        guard let searchTerm = searchController.searchBar.text else {
            log.error("It seems like a search text was typed, but could not be retrieved.")
            return
        }
        interpreter?.userSearches(for: searchTerm)
    }
    
}

extension GamesViewController: GameModificationDelegate {
    
    func gameDetailChanged(for modifiedGame: Game) {
        interpreter?.delegateWasNotified(about: modifiedGame)
    }
    
}

extension GamesViewController: GameDetailDelegate {
    
    func gamesWereModified() {
        interpreter?.delegateWasNotifiedAboutModifiedGames()
    }
    
}

// MARK: - Delegate Protocols
