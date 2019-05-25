//
//  HomePresenter.swift
//  Spielebuch
//
//  Created by Benno Kress on 25.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

class HomePresenterImplementation {
    
    private unowned var view: HomeView
    
    /// This initializer is called when a new HomeView is created.
    init(for view: HomeView) {
        self.view = view
    }
    
}

// MARK: - HomePresenter Protocol
protocol HomePresenter: class {
    
    /// Display the provided data on the HomeView
    func setup(with setupData: VIPViewSetupData?)
    
}

// MARK: - HomePresenter Conformance
extension HomePresenterImplementation: HomePresenter {
    
    func setup(with setupData: VIPViewSetupData?) {
        guard let data = setupData, case let VIPViewSetupData.home(someBoolValue) = data else { return }
        view.doSomething(with: someBoolValue)
    }
    
}
