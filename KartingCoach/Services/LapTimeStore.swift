//
//  LapTimeStore.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import ReactiveSwift

protocol CircuitStore {
    var circuits: Property<[Circuit]> { get }
}

protocol HasCircuitStore {
    var circuitStore: CircuitStore { get }
}

final class LapTimeStore: CircuitStore {
    let circuits: Property<[Circuit]> = Property(value:[
        Circuit(name: "Hořovice", races: [Race(date: Date(), lapTimes: [LapTime(duration: 55000)])])
        ])
}
