//
//  FlowController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 06/08/2017.
//

protocol FlowController: class {
    var children: [FlowController] { get set }
    
    func start()
}

extension FlowController {
    func add(child flowController: FlowController) {
        children.append(flowController)
        flowController.start()
    }
}
