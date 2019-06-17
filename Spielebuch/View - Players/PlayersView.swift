//
//  PlayersView.swift
//  Spielebuch
//
//  Created by Benno Kress on 17.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import SnapKit
import UIKit

class PlayersViewController: VIPViewController {
    
    private var interpreter: PlayersInterpreter?
    
    // Data
    private var groupedPlayers: [String: [Player]] = [:]
    
    // View Components
    private let playersTableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    // View State
    private var sections: [String] { return groupedPlayers.keys.sorted { $0 < $1 } }
    private var isSearchActive = false
    
}

// MARK: - View Lifecycle

extension PlayersViewController {
    
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

extension PlayersViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        setupPlayersTableView()
        setupNavigationBar()
        setupSearchController()
    }
    
    // MARK: Navigation Bar
    private func setupNavigationBar() {
        title = "Players"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        setupBarButtonItems()
    }
    
    private func setupBarButtonItems() {
        let addBarButtonItem = setupBarButtonItem(withUIImageNamed: "NavigationBarItem-Add", andAction: #selector(addItem))
        let searchBarButtonItem = setupBarButtonItem(withUIImageNamed: "NavigationBarItem-Search", andAction: #selector(searchItems))
        navigationItem.rightBarButtonItem = addBarButtonItem
        navigationItem.leftBarButtonItem = searchBarButtonItem
    }
    
    private func setupBarButtonItem(withUIImageNamed assetName: String, andAction action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: UIImage(named: assetName), style: .plain, target: self, action: action)
        item.tintColor = .black
        item.width = 24
        return item
    }
    
    @objc func addItem() {
        interpreter?.userTappedAddPlayerButton()
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
        searchController.searchBar.placeholder = "Search in Players"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: Players Table View
    private func setupPlayersTableView() {
        playersTableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.playerCell.rawValue)
        playersTableView.dataSource = self
        playersTableView.delegate = self
        view.addSubview(playersTableView)
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        playersTableView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view)
        }
    }
    
}

// MARK: - Private Helpers

extension PlayersViewController {
    
    private enum Identifier: String {
        case playerCell
    }
    
    private func reloadPlayersTableViewData() {
        DispatchQueue.main.async {
            self.playersTableView.reloadData()
        }
    }
    
    private func push(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func player(at indexPath: IndexPath) -> Player {
        let section = self.section(at: indexPath)
        guard let playersInSection = groupedPlayers[section] else {
            let errorMessage = "Error while searching for Players in Section \"\(section)\""; log.error(errorMessage); fatalError(errorMessage)
        }
        return playersInSection[indexPath.row]
    }
    
    private func section(at indexPath: IndexPath) -> String {
        return sections[indexPath.section]
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

extension PlayersViewController {
    
    private func initializeVIP() {
        let presenter = PlayersPresenterImplementation(for: self as PlayersView)
        self.interpreter = PlayersInterpreterImplementation(with: presenter)
    }
    
}

// MARK: View Protocol
// --> Every action provided to the Presenter

protocol PlayersView: class {
    
    /// Replaces the currently displayed players by the ones provided.
    /// - Parameter groupedPlayers: The players to be displayed.
    func updatePlayers(from groupedPlayers: [String: [Player]])
    
    /// Presents a PlayerDetailView with the provided Data.
    /// - Parameter setupData: The data used to set up the PlayerDetailView.
    func showPlayerDetailView(with setupData: VIPViewSetupData)
    
    /// Presents an empty PlayerModificationView.
    func showNewPlayerView()
    
    /// Dismisses the search controller.
    func dismissSearchController()
    
}

extension PlayersViewController: PlayersView {
    
    func updatePlayers(from groupedPlayers: [String: [Player]]) {
        self.groupedPlayers = groupedPlayers
        reloadPlayersTableViewData()
    }
    
    func showPlayerDetailView(with setupData: VIPViewSetupData) {
        let playerDetailViewController = PlayerDetailViewController()
        playerDetailViewController.delegates.append(self)
        playerDetailViewController.setup(with: setupData)
        push(playerDetailViewController)
    }
    
    func showNewPlayerView() {
        log.info("New Player View was requested")
//        let newPlayerViewController = PlayerModificationViewController()
//        newPlayerViewController.delegates.append(self)
//        let newPlayerNavigationController = UINavigationController(rootViewController: newPlayerViewController)
//        present(newPlayerNavigationController, animated: true)
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

extension PlayersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sections[section]
        guard let playerCountForSection = groupedPlayers[sectionTitle]?.count else {
            let errorMessage = "Error while searching for Players in Section \"\(sectionTitle)\""; log.error(errorMessage); fatalError(errorMessage)
        }
        return playerCountForSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = self.player(at: indexPath)
        
        let playerCell = tableView.dequeueReusableCell(withIdentifier: Identifier.playerCell.rawValue, for: indexPath)
        playerCell.textLabel?.text = player.displayname
        playerCell.accessoryType = .disclosureIndicator
        return playerCell
    }
    
}

// MARK: - Delegate Implementations

extension PlayersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = self.player(at: indexPath)
        interpreter?.userTapped(player, withActiveSearch: isSearchActive)
        DispatchQueue.main.async {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

extension PlayersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        isSearchActive = true
        guard let searchTerm = searchController.searchBar.text else {
            log.error("It seems like a search text was typed, but could not be retrieved."); return
        }
        interpreter?.userSearches(for: searchTerm)
    }
    
}

//extension PlayersViewController: PlayerModificationDelegate {
//    
//    func playerDetailChanged(for modifiedPlayer: Player) {
//        interpreter?.delegateWasNotified(about: modifiedPlayer)
//    }
//    
//}

extension PlayersViewController: PlayerDetailDelegate {
    
    func playersWereModified() {
        interpreter?.delegateWasNotifiedAboutModifiedPlayers()
    }
    
}

// MARK: - Delegate Protocols
