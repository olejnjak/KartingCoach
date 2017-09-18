//
//  CircuitListViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 18/09/2017.
//

import UIKit

protocol CircuitListFlowDelegate: class {
    
}

final class CircuitListViewController: BaseViewController {
    
    weak var flowDelegate: CircuitListFlowDelegate?
    
    // MARK: Initializers
    
    override init() {
        super.init()
        title = L10n.CircuitList.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
