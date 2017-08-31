//
//  Circuit.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 01/09/2017.
//

import Foundation

struct Circuit {
    let name: String
    let races: [Race]
    
    var bestTime: LapTime? {
        return races.flatMap { $0.bestTime }.min()
    }
}
