//
//  CircuitsFlowController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 18/09/2017.
//

import UIKit

final class CircuitsFlowController: FlowController, CircuitListFlowDelegate {
    var children = [FlowController]()
    
    private let navigationController: UINavigationController
    
    // MARK: Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Public interface
    
    func start() {
        let circuitListVC = CircuitListViewController()
        circuitListVC.flowDelegate = self
        navigationController.title = circuitListVC.title
        navigationController.viewControllers = [circuitListVC]
    }
}
