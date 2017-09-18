//
//  AppFlowController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 06/08/2017.
//

import UIKit

final class AppFlowController: FlowController {
    var children = [FlowController]()
    
    private var window: UIWindow
    
    // MARK: Initializers
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Flow controller
    
    func start() {
        let tabBarVC = UITabBarController()
        
        let circuitsNav = UINavigationController()
        let circuitsFlow = CircuitsFlowController(navigationController: circuitsNav)
        let racesNav = UINavigationController()
        let racesFlow = RacesFlowController(navigationController: racesNav)
        let profileNav = UINavigationController()
        let profileFlow = ProfileFlowController(navigationController: profileNav)
        
        add(child: circuitsFlow)
        add(child: racesFlow)
        add(child: profileFlow)
        
        tabBarVC.viewControllers = [circuitsNav, racesNav, profileNav]
        
        window.rootViewController = tabBarVC
    }
}
