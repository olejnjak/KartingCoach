//
//  NewRaceViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import ReactiveSwift
import enum Result.NoError

typealias NewRaceViewModelFactory = (Circuit) -> NewRaceViewModeling

protocol HasNewRaceViewModelFactory {
    var newRaceVMFactory: NewRaceViewModelFactory { get }
}

protocol NewRaceViewModeling {
    var items: MutableProperty<[LapTime]> { get }
    
    func addNewLap()
}

final class NewRaceViewModel: NewRaceViewModeling {
    
    let items = MutableProperty<[LapTime]>([.zero])
    
    // MARK: Initializers
    
    init(circuit: Circuit) {
        
    }
    
    func addNewLap() {
        guard items.value.last != .zero else { return }
        items.value = items.value + [.zero]
    }
    
}
