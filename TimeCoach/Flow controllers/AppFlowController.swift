//
//  AppFlowController.swift
//  TimeCoach
//
//  Created by Jakub Olejník on 06/08/2017.
//

import UIKit

final class AppFlowController: FlowController {
    
    private var window: UIWindow
    
    // MARK: Initializers
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Flow controller
    
    func start() {
        window.rootViewController = ViewController()
    }
    
}
