//
//  AppDependency.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import Foundation

final class AppDependency: HasNoDependency {
    lazy var circuitStore: CircuitStore = LapTimeStore(dependencies: self)
}

protocol HasNoDependency { }

extension AppDependency: HasCircuitStore { }

let dependencies = AppDependency()
