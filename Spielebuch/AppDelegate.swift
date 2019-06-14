//
//  AppDelegate.swift
//  Spielebuch
//
//  Created by Benno Kress on 05.02.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import CoreData
import SwiftyBeaver
import UIKit

/// Global Logging via SwiftyBeaver
let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupLogging()
        window = UIWindow(frame: UIScreen.main.bounds)
        setupTabBar(with: viewControllersForTabBar)
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: Core Data

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Spielebuch")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

// MARK: Tab Bar
extension AppDelegate {
    
    enum TabBarItemParameters: String {
        case home = "Home"
        case scores = "Scores"
        case games = "Games"
        case players = "Players"
        
        var title: String { return rawValue }
        
        var icon: UIImage? {
            switch self {
            case .home: return UIImage()
            case .scores: return UIImage()
            case .games: return UIImage(named: "TabBarItem-Games")
            case .players: return UIImage()
            }
        }
    }
    
    private var viewControllersForTabBar: [UIViewController] {
        let gamesViewController = GamesViewController()
        let gamesNavigationController = UINavigationController(rootViewController: gamesViewController)
        gamesNavigationController.title = TabBarItemParameters.games.title
        
        // TODO: Instantiate the View Controllers for all other tabs …
        
        return [gamesNavigationController]
    }
    
    private func setupTabBar(with viewControllers: [UIViewController]) {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
        guard viewControllers.count > 0, let tabBarItems = tabBarController.tabBar.items else {
            log.error("No View Controllers defined for Tab Bar, will be empty ...")
            window?.rootViewController = tabBarController
            return
        }
        
        for item in tabBarItems {
            let rawTitle = item.title ?? ""
            if let parameters = TabBarItemParameters(rawValue: rawTitle) {
                item.image = parameters.icon
                item.selectedImage = parameters.icon
            } else {
                log.warning("No TabBarItem named \"\(rawTitle)\" found ")
            }
        }
        
        window?.rootViewController = tabBarController
    }
    
}

// MARK: Logging
extension AppDelegate {
    
    private func setupLogging() {
        let console = ConsoleDestination()  // log to Xcode Console
        console.format = "$DHH:mm:ss$d $C$L$c → $N.$F:$l\n         $C$M$c"
        log.addDestination(console)
    }
    
}
