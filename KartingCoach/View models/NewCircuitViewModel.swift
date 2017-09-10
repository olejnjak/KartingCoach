//
//  NewCircuitViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import ReactiveSwift

enum NewCircuitError: Error {
    case emptyName
    case exists
}

protocol NewCircuitViewModeling {
    var addCircuit: Action<String?, Circuit, NewCircuitError> { get }
}

final class NewCircuitViewModel: NewCircuitViewModeling {
    
    typealias Dependencies = HasCircuitStore
    
    private let circuitStore: CircuitStore
    
    lazy var addCircuit: Action<String?, Circuit, NewCircuitError> = Action { [unowned self] circuitName in
        return SignalProducer<Circuit, NewCircuitError> { [unowned self] sink, _ in
            guard let circuitName = circuitName else {
                sink.send(error: .emptyName)
                return
            }

            guard self.circuitStore.circuit(for: circuitName) == nil else {
                sink.send(error: .exists)
                return
            }
            
            let circuit = Circuit(name: circuitName, races: [])
            let currentCircuits = self.circuitStore.circuits.value
            self.circuitStore.circuits.value = currentCircuits + [circuit]
            
            sink.send(value: circuit)
            sink.sendCompleted()
        }
    }
    
    init(dependencies: Dependencies) {
        self.circuitStore = dependencies.circuitStore
    }
    
}
