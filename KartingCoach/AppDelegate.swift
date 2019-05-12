//
//  AppDelegate.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 06/08/2017.
//

import UIKit
import FirebaseCore
import IQKeyboardManagerSwift

final class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var appFlow: AppFlowController = AppFlowController(window: window!)
    
    var window: UIWindow?

    // MARK: UIApplication delegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        setupAppearance()
        
        IQKeyboardManager.shared.enable = true
        
        appFlow.start()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let store = dependencies.circuitStore
        return store.import(from: url)
    }

    // MARK: Private helpers
    
    private func setupAppearance() {
        let tableView = UITableView.appearance()
        tableView.tableFooterView = UIView()
    }
}
