//
//  RacesFlowController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 18/09/2017.
//

import UIKit

final class RacesFlowController: FlowController, RaceListFlowDelegate {
    var children = [FlowController]()
    
    private let navigationController: UINavigationController
    
    // MARK: Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Public interface
    
    func start() {
        let raceListVC = RaceListViewController()
        raceListVC.flowDelegate = self
        navigationController.title = raceListVC.title
        navigationController.viewControllers = [raceListVC]
    }
}
