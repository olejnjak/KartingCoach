//
//  AppDependency.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import Foundation

struct AppDependency: HasCircuitStore {
    
    let circuitStore: CircuitStore
    
}

let dependencies = AppDependency(circuitStore: LapTimeStore())
