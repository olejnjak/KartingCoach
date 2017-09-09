//
//  NewCircuitViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import UIKit

protocol NewCircuitFlowDelegate: class {
    func newCircuitDidCancel(_ viewController: NewCircuitViewController)
}

final class NewCircuitViewController: BaseViewController {
    
    weak var flowDelegate: NewCircuitFlowDelegate?
    
    // MARK: Initiliazers
    
    init(viewModel: NewCircuitViewModeling) {
        super.init()
        title = L10n.NewCircuit.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
    }
    
    // MARK: UI actions
    
    @objc
    private func cancelTapped() {
        flowDelegate?.newCircuitDidCancel(self)
    }
}
