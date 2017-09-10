//
//  NewCircuitViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import ReactiveSwift

protocol NewCircuitViewModeling {
    var addCircuit: Action<Void, Circuit, NewCircuitError> { get }
    var doneEnabled: Property<Bool> { get }
    var name: MutableProperty<String?> { get }
}

final class NewCircuitViewModel: NewCircuitViewModeling {
    
    typealias Dependencies = HasCircuitStore
    
    private let circuitStore: CircuitStore
    
    let name = MutableProperty<String?>(nil)
    let doneEnabled: Property<Bool>
    
    // MARK: Actions
    
    lazy var addCircuit: Action<Void, Circuit, NewCircuitError> = Action(enabledIf: self.doneEnabled) { [unowned self] in
        return SignalProducer<Circuit, NewCircuitError> { [unowned self] sink, _ in
            guard let circuitName = self.name.value, !circuitName.isEmpty else {
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
    
    // MARK: - Initialization
    
    init(dependencies: Dependencies) {
        self.circuitStore = dependencies.circuitStore
        self.doneEnabled = self.name.map { $0 ?? "" }.map { !$0.isEmpty }
    }
    
}
