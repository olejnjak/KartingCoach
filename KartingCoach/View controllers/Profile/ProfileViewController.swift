//
//  ProfileViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 18/09/2017.
//

import UIKit

protocol ProfileFlowDelegate: class {
    
}

final class ProfileViewController: BaseViewController {
    
    weak var flowDelegate: ProfileFlowDelegate?
    
    // MARK: Initializers
    
    override init() {
        super.init()
        title = L10n.Profile.title
        tabBarItem.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
