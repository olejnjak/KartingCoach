//
//  CircuitDetailViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import ReactiveSwift

protocol CircuitDetailViewModeling: CircuitDetailHeaderViewModeling {
    var reloadData: Signal<Void, Never> { get }
    
    var newRaceVM: NewRaceViewModeling { get }
    
    func numberOfRows(in section: Int) -> Int
    func race(for indexPath: IndexPath) -> Race
}

final class CircuitDetailViewModel: CircuitDetailViewModeling {
    typealias Dependencies = HasCircuitStore & HasNewRaceVMFactory
    
    let name: Property<String>
    let bestTime: Property<LapTime?>
    let averageTime: Property<LapTime?>
    let races: Property<[Race]>
    
    var newRaceVM: NewRaceViewModeling { return newRaceVMFactory(circuit.value) }
    
    lazy var reloadData: Signal<Void, Never> = self.races.signal.map { _ in }
    
    private let circuit: MutableProperty<Circuit>
    
    private let newRaceVMFactory: NewRaceVMFactory
    private let circuitStore: CircuitStore
    
    // MARK: Initializers
    
    init(dependencies: Dependencies, circuit c: Circuit) {
        newRaceVMFactory = dependencies.newRaceVMFactory
        circuitStore = dependencies.circuitStore
        
        circuit = MutableProperty(c)
        
        // Binding
        name = circuit.map { $0.name }
        bestTime = circuit.map { $0.bestTime }
        averageTime = circuit.map { $0.averageTime }
        races = circuit.map { $0.races }
        
        setupBindings()
    }
    
    private func setupBindings() {
        dependencies.circuitStore.circuits.producer.startWithValues { [weak self] in
            guard let newCircuit = $0.first(where: { $0 == self?.circuit.value }) else { return }
            self?.circuit.value = newCircuit
        }
    }
    
    // MARK: - Public API
    
    func numberOfRows(in section: Int) -> Int {
        return races.value.count
    }
    
    func race(for indexPath: IndexPath) -> Race {
        return races.value[indexPath.row]
    }
}
