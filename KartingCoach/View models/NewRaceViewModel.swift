//
//  NewRaceViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import UIKit
import ReactiveSwift

typealias NewRaceVMFactory = (Circuit) -> NewRaceViewModeling

protocol HasNewRaceVMFactory {
    var newRaceVMFactory: NewRaceVMFactory { get }
}

protocol NewRaceViewModeling {
    var items: MutableProperty<[LapTime]> { get }
    
    func addNewLap()
    func save()
}

final class NewRaceViewModel: NewRaceViewModeling {
    typealias Dependencies = HasCircuitStore
    
    let items = MutableProperty<[LapTime]>([.zero])
    
    private let circuit: Circuit
    private let circuitStore: CircuitStore
    
    // MARK: Initializers
    
    init(dependencies: Dependencies, circuit c: Circuit) {
        circuit = c
        circuitStore = dependencies.circuitStore
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
        circuitStore.circuits.value = currentCircuits
    }
}
