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
//        let circuitListVM = CircuitListViewModel(dependencies: dependencies)
//        let circuitListVC = CircuitListViewController(viewModel: circuitListVM)
//        circuitListVC.flowDelegate = self
//        navigationController.viewControllers = [circuitListVC]
    }
}

extension CircuitFlowController: CircuitListFlowDelegate {
    
    func circuitList(_ viewController: CircuitListViewController, didSelect circuit: Circuit) {
//        let detailVM = CircuitDetailViewModel(circuit: circuit, dependencies: dependencies)
//        let detailVC = CircuitDetailViewController(viewModel: detailVM)
//        detailVC.flowDelegate = self
//        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func circuitListDidTapNewCircuit(_ viewController: CircuitListViewController) {
//        let newCircuitVM = NewCircuitViewModel(dependencies: dependencies)
//        let newCircuitVC = NewCircuitViewController(viewModel: newCircuitVM)
//        let newCircuitNav = UINavigationController(rootViewController: newCircuitVC)
//        newCircuitVC.flowDelegate = self
//        viewController.present(newCircuitNav, animated: true, completion: nil)
    }
}

extension CircuitFlowController: NewCircuitFlowDelegate {
    
    func newCircuitDidCancel(_ viewController: NewCircuitViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func newCircuitDidAdd(_ viewController: NewCircuitViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}

extension CircuitFlowController: CircuitDetailFlowDelegate {
    
    func circuitDetailDidTapAddRace(_ viewController: CircuitDetailViewController, circuitVM: CircuitDetailViewModeling) {
        let newRaceVC = NewRaceViewController(viewModel: circuitVM.newRaceVM)
        let newRaceNav = UINavigationController(rootViewController: newRaceVC)
        newRaceVC.flowDelegate = self
        viewController.present(newRaceNav, animated: true, completion: nil)
    }
    
}

extension CircuitFlowController: NewRaceFlowDelegate {
    
    func newRaceDidCancel(_ viewController: NewRaceViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func newRaceDidSave(_ viewController: NewRaceViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
