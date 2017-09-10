//
//  LapTimeStore.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import ReactiveSwift

protocol CircuitStore {
    var circuits: MutableProperty<[Circuit]> { get }
    
    func circuit(for name: String) -> Circuit?
}

protocol HasCircuitStore {
    var circuitStore: CircuitStore { get }
}

final class LapTimeStore: CircuitStore {
    let circuits: MutableProperty<[Circuit]> = MutableProperty([
        Circuit(name: "Hořovice", races: [
            Race(date: Date(), lapTimes: [
                LapTime(duration: 55001),
                LapTime(duration: 56321)
            ])
        ])
    ])
    
    func circuit(for name: String) -> Circuit? {
        return circuits.value.first(where: { $0.name == name })
    }
}
