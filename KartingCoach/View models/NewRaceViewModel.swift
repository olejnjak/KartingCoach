//
//  NewRaceViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import ReactiveSwift
import enum Result.NoError

typealias NewRaceViewModelFactory = (Circuit) -> NewRaceViewModeling

protocol HasNewRaceViewModelFactory {
    var newRaceVMFactory: NewRaceViewModelFactory { get }
}

protocol NewRaceViewModeling {
    var items: MutableProperty<[LapTime]> { get }
    
    func addNewLap()
    func save()
}

final class NewRaceViewModel: NewRaceViewModeling {
    typealias Dependencies = HasCircuitStore
    
    private let circuit: Circuit
    private let dependencies: Dependencies
    
    let items = MutableProperty<[LapTime]>([.zero])
    
    // MARK: Initializers
    init(circuit: Circuit, dependencies: Dependencies) {
        self.circuit = circuit
        self.dependencies = dependencies
    }
    
    func addNewLap() {
        guard items.value.last != .zero else { return }
        items.value = items.value + [.zero]
    }
    
    func save() {
        let race = Race(date: Date(), lapTimes: items.value.filter { $0 != .zero })
        let races: [Race] = self.circuit.races + [race]
        let circuit = Circuit(name: self.circuit.name, races: races)
        var currentCircuits = dependencies.circuitStore.circuits.value
        currentCircuits.enumerated().forEach { index, element in
            guard element == circuit else { return }
            currentCircuits[index] = circuit
        }
        dependencies.circuitStore.circuits.value = currentCircuits
    }
    
}
