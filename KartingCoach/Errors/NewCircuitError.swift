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
            return "Name cannot be empty"
        case .exists:
            return "Name already exists"
        }
    }
    
    var message: String? {
        return nil
    }
    
}
