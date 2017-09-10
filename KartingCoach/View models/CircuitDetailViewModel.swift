//
//  CircuitDetailViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import ReactiveSwift

protocol CircuitDetailViewModeling: CircuitDetailHeaderViewModeling {
    var races: Property<[Race]> { get }
    
    var newRaceVM: NewRaceViewModeling { get }
}

final class CircuitDetailViewModel: CircuitDetailViewModeling {
    typealias Dependencies = HasCircuitStore
    typealias Factories = HasNewRaceViewModelFactory
    
    let name: Property<String>
    let bestTime: Property<LapTime?>
    let averageTime: Property<LapTime?>
    let races: Property<[Race]>
    
    var newRaceVM: NewRaceViewModeling { return factories.newRaceVMFactory(circuit.value) }
    
    private let circuit: MutableProperty<Circuit>
    private let factories: Factories
    private let dependencies: Dependencies
    
    // MARK: Initializers
    
    init(circuit: Circuit, factories: Factories, dependencies: Dependencies) {
        self.circuit = MutableProperty(circuit)
        self.factories = factories
        self.dependencies = dependencies
        
        // Binding
        self.name = self.circuit.map { $0.name }
        self.bestTime = self.circuit.map { $0.bestTime }
        self.averageTime = self.circuit.map { $0.averageTime }
        self.races = self.circuit.map { $0.races }
        
        setupBindings()
    }
    
    private func setupBindings() {
        dependencies.circuitStore.circuits.producer.startWithValues { [weak self] in
            guard let newCircuit = $0.first(where: { $0 == self?.circuit.value }) else { return }
            self?.circuit.value = newCircuit
        }
    }
}
