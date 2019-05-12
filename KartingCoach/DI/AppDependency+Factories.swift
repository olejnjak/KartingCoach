//
//  AppDependency+Factories.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 12/05/2019.
//

import Foundation

extension AppDependency: HasNewRaceVMFactory {
    var newRaceVMFactory: NewRaceVMFactory {
        return { NewRaceViewModel(dependencies: self, circuit: $0) }
    }
}
