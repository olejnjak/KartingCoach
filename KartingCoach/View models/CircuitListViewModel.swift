//
//  CircuitListViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import ReactiveSwift

protocol CircuitListViewModeling {
    var circuits: MutableProperty<[Circuit]> { get }
    
    var storeDataFile: URL { get }
}

final class CircuitListViewModel: CircuitListViewModeling {
    typealias Dependencies = HasCircuitStore
    
    let circuits: MutableProperty<[Circuit]>
    
    let storeDataFile: URL
    
    // MARK: Initializers
    
    init(dependencies: Dependencies) {
        circuits = dependencies.circuitStore.circuits
        storeDataFile = dependencies.circuitStore.dataFile
    }
}
