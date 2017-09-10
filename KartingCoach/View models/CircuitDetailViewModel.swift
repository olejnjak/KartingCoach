//
//  CircuitDetailViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

protocol CircuitDetailViewModeling: CircuitDetailHeaderViewModeling {
    var name: String { get }
    var bestTime: LapTime? { get }
    var averageTime: LapTime? { get }
    var races: [Race] { get }
    
    var newRaceVM: NewRaceViewModeling { get }
}

final class CircuitDetailViewModel: CircuitDetailViewModeling {
    typealias Dependencies = HasNewRaceViewModelFactory
    
    var name: String { return circuit.name }
    var bestTime: LapTime? { return circuit.bestTime }
    var averageTime: LapTime? { return circuit.averageTime }
    var races: [Race] { return circuit.races }
    
    var newRaceVM: NewRaceViewModeling { return newRaceVMFactory(circuit) }
    
    private let circuit: Circuit
    private let newRaceVMFactory: NewRaceViewModelFactory
    
    // MARK: Initializers
    
    init(circuit: Circuit, dependencies: Dependencies) {
        self.circuit = circuit
        self.newRaceVMFactory = dependencies.newRaceVMFactory
    }
}
