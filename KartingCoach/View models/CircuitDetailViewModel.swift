//
//  CircuitDetailViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

protocol CircuitDetailViewModeling {
    var name: String { get }
}

final class CircuitDetailViewModel: CircuitDetailViewModeling {
    let name: String
    
    // MARK: Initializers
    
    init(circuit: Circuit) {
        name = circuit.name
    }
    
}
