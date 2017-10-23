//
//  NewRaceViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import UIKit
import TesseractOCR
import ReactiveSwift

typealias NewRaceViewModelFactory = (Circuit) -> NewRaceViewModeling

protocol HasNewRaceViewModelFactory {
    var newRaceVMFactory: NewRaceViewModelFactory { get }
}

protocol NewRaceViewModeling {
    var items: MutableProperty<[LapTime]> { get }
    var recognizeLapTimes: Action<UIImage, [LapTime], NoError> { get }
    
    func addNewLap()
    func save()
}

final class NewRaceViewModel: NewRaceViewModeling {
    typealias Dependencies = HasCircuitStore
    
    private let circuit: Circuit
    private let dependencies: Dependencies
    
    let items = MutableProperty<[LapTime]>([.zero])
    lazy var recognizeLapTimes: Action<UIImage, [LapTime], NoError> = Action { [unowned self] in
        return self.recognizeTesseractProducer(for: $0)
            .map { $0.recognizedText.components(separatedBy: .newlines) }
            .map { $0.flatMap { LapTime(string: $0) } }
    }
    
    // MARK: Initializers
    
    init(circuit: Circuit, dependencies: Dependencies) {
        self.circuit = circuit
        self.dependencies = dependencies
        
        setupBindings()
    }
    
    func addNewLap() {
        guard items.value.last != .zero else { return }
        items.value = items.value + [.zero]
    }
    
    func save() {
        let race = Race(date: Date(), lapTimes: items.value.filter { $0 != .zero })
        let races: [Race] = self.circuit.races + [race]
        let circuit = Circuit(name: self.circuit.name, races: races)
        var currentCircuits = dependencies.circuitStore.circuits.value
        currentCircuits.enumerated().forEach { index, element in
            guard element == circuit else { return }
            currentCircuits[index] = circuit
        }
        dependencies.circuitStore.circuits.value = currentCircuits
    }
    
    // MARK: Private helpers
    
    private func recognizeTesseractProducer(for image: UIImage) -> SignalProducer<G8Tesseract, NoError> {
        let recognizeOperation = G8RecognitionOperation(language: "eng")!
        recognizeOperation.tesseract.image = image
        recognizeOperation.tesseract.charWhitelist = "0123456789:."
        return recognizeOperation.reactive.recognizeProducer()
    }
    
    private func setupBindings() {
        items <~ SignalProducer(recognizeLapTimes.values).withLatest(from: items.producer).map { $0 + $1 }
    }
}
