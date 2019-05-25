//
//  HomeView.swift
//  Spielebuch
//
//  Created by Benno Kress on 25.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

class HomeViewController: VIPViewController {
    
    private var interpreter: HomeInterpreter?
    
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
        let presenter = HomePresenterImplementation(for: self as HomeView)
        self.interpreter = HomeInterpreterImplementation(with: presenter)
    }
    
    /// Unwind Segue Setup
    @IBAction func unwindToHomeView(sender: UIStoryboardSegue) {
        VIPSegue.unwindToHome.prepare(from: sender, to: self as VIPViewController)
    }
    
}

// MARK: - HomeView Protocol
protocol HomeView: class {
    
    /// Makes the method from the superclass VIPViewController visible in order to pass data to a segue destination view controller.
    func setPassOnData(to passOnData: VIPViewSetupData?)
    
    /// Normally used to display the value, but used in console for demonstration purposes here.
    func doSomething(with someBoolValue: Bool)
    
}

// MARK: - HomeView Conformance
extension HomeViewController: HomeView {
    
    func doSomething(with someBoolValue: Bool) {
        print(someBoolValue ? "yup" : "nope")
    }
    
}

