//
//  CircuitFlowController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import UIKit

final class CircuitFlowController: FlowController {
    var children = [FlowController]()
    
    private let navigationController: UINavigationController
    
    // MARK: Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Flow controller
    
    func start() {
        let circuitListVM = CircuitListViewModel(dependencies: dependencies)
        let circuitListVC = CircuitListViewController(viewModel: circuitListVM)
        
        navigationController.viewControllers = [circuitListVC]
    }
    
}
