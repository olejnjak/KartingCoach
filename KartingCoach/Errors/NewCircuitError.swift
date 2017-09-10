//
//  NewCircuitError.swift
//  KartingCoach
//
//  Created by Lukáš Hromadník on 10.09.17.
//

import Foundation

enum NewCircuitError: Error {
    case emptyName
    case exists
}

extension NewCircuitError: DisplayableError {
    
    var title: String? {
        switch self {
        case .emptyName:
            return L10n.NewCircuit.Errors.EmptyName.title
        case .exists:
            return L10n.NewCircuit.Errors.Exists.title
        }
    }
    
    var message: String? {
        return nil
    }
    
}
