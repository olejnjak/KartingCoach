//
//  RaceListViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 18/09/2017.
//

import UIKit

protocol RaceListFlowDelegate: class {
    
}

final class RaceListViewController: BaseViewController {
    
    weak var flowDelegate: RaceListFlowDelegate?
    
    // MARK: Initializers
    
    override init() {
        super.init()
        title = L10n.RaceList.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
