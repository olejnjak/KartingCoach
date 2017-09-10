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
        let circuitNav = UINavigationController()
        let circuitFlow = CircuitFlowController(navigationController: circuitNav)
        
        add(child: circuitFlow)
        
        window.rootViewController = circuitNav
    }
}
