//
//  AppDependency.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import Foundation

struct AppDependency: HasCircuitStore, HasNewRaceViewModelFactory {
    
    let circuitStore: CircuitStore
    let newRaceVMFactory: NewRaceViewModelFactory
    
}

let dependencies = AppDependency(circuitStore: LapTimeStore(), newRaceVMFactory: { NewRaceViewModel(circuit: $0) })
