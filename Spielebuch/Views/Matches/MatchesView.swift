//
//  MatchesView.swift
//  Spielebuch
//
//  Created by Benno Kress on 21.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

class MatchesViewController: VIPViewController {
    
    private var interpreter: MatchesInterpreter?
    
    // Data
    private var groupedMatches: [String: [Match]] = [:]
    
    // View Components
    private let matchesTableView = UITableView()
    
    // View State
    private var sections: [String] { return groupedMatches.keys.sorted { $0 < $1 } }
    private var isFilterActive = false
    
}

// MARK: - View Lifecycle

extension MatchesViewController {
    
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

extension MatchesViewController {
    
    private func setupView() {
        view.backgroundColor = .background
        setupMatchesTableView()
        setupNavigationBar()
    }
    
    // MARK: Navigation Bar
    private func setupNavigationBar() {
        title = "Matches"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        setupBarButtonItems()
    }
    
    private func setupBarButtonItems() {
        let addBarButtonItem = setupBarButtonItem(withUIImageNamed: "NavigationBarItem-Add", andAction: #selector(addItem))
        let filterBarButtonItem = setupBarButtonItem(withUIImageNamed: "NavigationBarItem-Filter", andAction: #selector(filterItems))
        navigationItem.rightBarButtonItem = addBarButtonItem
        navigationItem.leftBarButtonItem = filterBarButtonItem
    }
    
    private func setupBarButtonItem(withUIImageNamed assetName: String, andAction action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: UIImage(named: assetName), style: .plain, target: self, action: action)
        item.tintColor = .black
        item.width = 24
        return item
    }
    
    @objc func addItem() {
        interpreter?.userTappedAddMatchButton()
    }
    
    @objc func filterItems() {
        log.info("Filtering by Game is not yet implemented")
    }
    
    // MARK: Matches Table View
    private func setupMatchesTableView() {
        matchesTableView.register(UITableViewCellWithSubtitle.self, forCellReuseIdentifier: Identifier.matchCell.rawValue)
        matchesTableView.dataSource = self
        matchesTableView.delegate = self
        view.addSubview(matchesTableView)
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        matchesTableView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view)
        }
    }
    
}

// MARK: - Private Helpers

extension MatchesViewController {
    
    private enum Identifier: String {
        case matchCell
    }
    
    private class UITableViewCellWithSubtitle: UITableViewCell {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    private func reloadMatchesTableViewData() {
        DispatchQueue.main.async {
            self.matchesTableView.reloadData()
        }
    }
    
    private func push(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func match(at indexPath: IndexPath) -> Match {
        let section = self.section(at: indexPath)
        guard let matchesInSection = groupedMatches[section] else {
            let errorMessage = "Error while searching for Matches in Section \"\(section)\""; log.error(errorMessage); fatalError(errorMessage)
        }
        return matchesInSection[indexPath.row]
    }
    
    private func section(at indexPath: IndexPath) -> String {
        return sections[indexPath.section]
    }
    
}

// MARK: - VIP Cycle
// --> Separation of View, Interpreter and Presenter (see https://github.com/bennokress/Minimal-VIP-Architecture)

extension MatchesViewController {
    
    private func initializeVIP() {
        let presenter = MatchesPresenterImplementation(for: self as MatchesView)
        self.interpreter = MatchesInterpreterImplementation(with: presenter)
    }
    
}

// MARK: - MatchesView Protocol
// --> Every action provided to the Presenter

protocol MatchesView: class {
    
    /// Replaces the currently displayed matches by the ones provided.
    /// - Parameter groupedMatches: The matches to be displayed.
    func updateMatches(from groupedMatches: [String: [Match]])
    
    /// Presents a MatchDetailView with the provided Data.
    /// - Parameter setupData: The data used to set up the MatchDetailView.
    func showMatchDetailView(with setupData: VIPViewSetupData)
    
    /// Presents an empty MatchModificationView.
    func showNewMatchView()
    
}

extension MatchesViewController: MatchesView {
    
    func updateMatches(from groupedMatches: [String: [Match]]) {
        self.groupedMatches = groupedMatches
        reloadMatchesTableViewData()
    }
    
    func showMatchDetailView(with setupData: VIPViewSetupData) {
        let matchDetailViewController = MatchDetailViewController()
        matchDetailViewController.delegates.append(self)
        matchDetailViewController.setup(with: setupData)
        push(matchDetailViewController)
    }
    
    func showNewMatchView() {
        let newMatchiewController = MatchModificationViewController()
        newMatchiewController.delegates.append(self)
        let newMatchNavigationController = UINavigationController(rootViewController: newMatchiewController)
        present(newMatchNavigationController, animated: true)
    }
    
}

// MARK: - Data Source Implementations

extension MatchesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sections[section]
        guard let matchCountForSection = groupedMatches[sectionTitle]?.count else {
            let errorMessage = "Error while searching for Matches in Section \"\(sectionTitle)\""; log.error(errorMessage); fatalError(errorMessage)
        }
        return matchCountForSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let match = self.match(at: indexPath)
        
        let matchCell = tableView.dequeueReusableCell(withIdentifier: Identifier.matchCell.rawValue, for: indexPath)
        matchCell.textLabel?.text = match.game.name
        matchCell.detailTextLabel?.text = match.date.shortDescription
        matchCell.accessoryType = .disclosureIndicator
        return matchCell
    }
    
}

// MARK: - Delegate Implementations

extension MatchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let match = self.match(at: indexPath)
        interpreter?.userTapped(match, withActiveFilter: isFilterActive)
        DispatchQueue.main.async {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

extension MatchesViewController: MatchModificationDelegate {

    func matchDetailChanged(for modifiedMatch: Match) {
        interpreter?.delegateWasNotified(about: modifiedMatch)
    }

}

extension MatchesViewController: MatchDetailDelegate {

    func matchesWereModified() {
        interpreter?.delegateWasNotifiedAboutModifiedMatches()
    }

}

// MARK: - Delegate Protocols
