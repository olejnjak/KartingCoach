//
//  Formatters.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import Foundation

enum Formatters {
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .medium
        return df
    }()
    
}
