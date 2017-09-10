//
//  NewRaceViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import UIKit

protocol NewRaceFlowDelegate: class {
    func newRaceDidCancel(_ viewController: NewRaceViewController)
}

final class NewRaceViewController: BaseViewController {
    
    weak var flowDelegate: NewRaceFlowDelegate?
    
    private let viewModel: NewRaceViewModeling
    
    // MARK: Initializers
    
    init(viewModel: NewRaceViewModeling) {
        self.viewModel = viewModel
        super.init()
        title = L10n.NewRace.title
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
        flowDelegate?.newRaceDidCancel(self)
    }
}
