//
//  HomeInterpreter.swift
//  Spielebuch
//
//  Created by Benno Kress on 25.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class HomeInterpreterImplementation {
    
    private let presenter: HomePresenter
    
    /// This initializer is called when a new HomeView is created.
    init(with presenter: HomePresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - HomeInterpreter Protocol
protocol HomeInterpreter: class {
    
    /// Takes the necessary actions when the HomeView is finished loading
    func viewWillAppear(with setupData: VIPViewSetupData?)
    
}

// MARK: - HomeInterpreter Conformance
extension HomeInterpreterImplementation: HomeInterpreter {
    
    func viewWillAppear(with setupData: VIPViewSetupData?) {
        presenter.setup(with: setupData)
    }
    
}
