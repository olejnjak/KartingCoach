//
//  AppDelegate.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 06/08/2017.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var appFlow: AppFlowController = AppFlowController(window: window!)
    
    var window: UIWindow?

    // MARK: UIApplication delegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        setupAppearance()
        appFlow.start()
        return true
    }

    // MARK: Private helpers
    
    private func setupAppearance() {
        let tableView = UITableView.appearance()
        tableView.tableFooterView = UIView()
    }
}
