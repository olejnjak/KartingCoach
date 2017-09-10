//
//  CircuitDetailViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import UIKit

final class CircuitDetailViewController: BaseViewController {
    
    // MARK: Initalizers
    
    init(viewModel: CircuitDetailViewModeling) {
        super.init()
        title = viewModel.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
