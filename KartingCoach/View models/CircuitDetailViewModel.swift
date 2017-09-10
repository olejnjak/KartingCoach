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
}

final class CircuitDetailViewModel: CircuitDetailViewModeling {
    let name: String
    let bestTime: LapTime?
    let averageTime: LapTime?
    let races: [Race]
    
    // MARK: Initializers
    
    init(circuit: Circuit) {
        name = circuit.name
        bestTime = circuit.bestTime
        averageTime = circuit.averageTime
        races = circuit.races
    }
    
}
