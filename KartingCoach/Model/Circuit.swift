//
//  Circuit.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 01/09/2017.
//

import Foundation

struct Circuit: Codable {
    let name: String
    let races: [Race]
    
    var bestTime: LapTime? {
        return races.compactMap { $0.bestTime }.min()
    }
    
    var averageTime: LapTime? {
        return races.compactMap { $0.averageTime }.average()
    }
}

extension Circuit: Equatable {
    static func == (lhs: Circuit, rhs: Circuit) -> Bool {
        return lhs.name == rhs.name
    }
}
