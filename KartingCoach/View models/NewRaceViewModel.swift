//
//  NewRaceViewModel.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import ReactiveSwift

typealias NewRaceViewModelFactory = (Circuit) -> NewRaceViewModeling

protocol HasNewRaceViewModelFactory {
    var newRaceVMFactory: NewRaceViewModelFactory { get }
}

protocol NewRaceViewModeling {
    
}

final class NewRaceViewModel: NewRaceViewModeling {
    
    // MARK: Initializers
    
    init(circuit: Circuit) {
        
    }
    
}
