//
//  VIPViewController.swift
//  Spielebuch
//
//  Created by Benno Kress on 25.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import UIKit

class VIPViewController: UIViewController {
    
    private(set) var setupData: VIPViewSetupData? = nil
    
    func setup(with setupData: VIPViewSetupData?) {
        self.setupData = setupData
    }
    
}
