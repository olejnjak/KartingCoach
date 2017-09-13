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
    let circuits: MutableProperty<[Circuit]>
    
    private let dataFile: URL = {
        let fm = FileManager.default
        let docsURL = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return URL(string: "data.json", relativeTo: docsURL)!
    }()

    // MARK: Initializers
    
    init() {
        circuits = MutableProperty([]) // cannot call loadCircuits directly as circuits are not initialized
        circuits.value = loadCircuits()
        setupBindings()
    }
    
    // MARK: Public interface
    
    func circuit(for name: String) -> Circuit? {
        return circuits.value.first(where: { $0.name == name })
    }
    
    // MARK: Private helpers
    
    private func setupBindings() {
        circuits.signal.take(duringLifetimeOf: self).observeValues {
            self.saveCircuits($0)
        }
    }
    
    private func loadCircuits() -> [Circuit] {
        let data = try? Data(contentsOf: dataFile)
        return data.flatMap { try? JSONDecoder().decode([Circuit].self, from: $0) } ?? []
    }
    
    private func saveCircuits(_ circuits: [Circuit]) {
        guard let encodedData = try? JSONEncoder().encode(circuits) else { return }
        
        _ = try? encodedData.write(to: dataFile, options: .atomic)
    }
}
