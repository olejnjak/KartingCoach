//
//  ProfileFlowController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 18/09/2017.
//

import UIKit

final class ProfileFlowController: FlowController, ProfileFlowDelegate {
    var children = [FlowController]()
    
    private let navigationController: UINavigationController
    
    // MARK: Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Public interface
    
    func start() {
        let profileVC = ProfileViewController()
        profileVC.flowDelegate = self
        navigationController.title = profileVC.title
        navigationController.viewControllers = [profileVC]
    }
}
