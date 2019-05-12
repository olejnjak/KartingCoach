//
//  LapTimeStore.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import ReactiveSwift

protocol CircuitStore {
    var circuits: MutableProperty<[Circuit]> { get }
    var dataFile: URL { get }
    
    func circuit(for name: String) -> Circuit?
    func `import`(from url: URL) -> Bool
}

protocol HasCircuitStore {
    var circuitStore: CircuitStore { get }
}

final class LapTimeStore: CircuitStore {
    typealias Dependencies = HasNoDependency
    
    let circuits: MutableProperty<[Circuit]>
    
    private let docsURL: URL = {
        let fm = FileManager.default
        return try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }()
    
    lazy var dataFile: URL = URL(string: "data.json", relativeTo: docsURL)!

    // MARK: Initializers
    
    init(dependencies: Dependencies) {
        circuits = MutableProperty([]) // cannot call loadCircuits directly as circuits are not initialized
        circuits.value = loadCircuits()
        setupBindings()
    }
    
    // MARK: Public interface
    
    func circuit(for name: String) -> Circuit? {
        return circuits.value.first(where: { $0.name == name })
    }
    
    func `import`(from url: URL) -> Bool {
        if let circuits = loadCircuits(from: url) {
            self.circuits.value = circuits
            return true
        }
        return false
    }
    
    // MARK: Private helpers
    
    private func setupBindings() {
        circuits.signal.take(duringLifetimeOf: self).observeValues {
            self.saveCircuits($0)
        }
    }
    
    private func loadCircuits() -> [Circuit] {
        return loadCircuits(from: dataFile) ?? []
    }
    
    private func loadCircuits(from url: URL) -> [Circuit]? {
        let data = try? Data(contentsOf: url)
        return data.flatMap { try? JSONDecoder().decode([Circuit].self, from: $0) }
    }
    
    private func saveCircuits(_ circuits: [Circuit]) {
        guard let encodedData = try? JSONEncoder().encode(circuits) else { return }
        
        _ = try? encodedData.write(to: dataFile, options: .atomic)
    }
}
