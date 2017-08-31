//
//  Race.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 01/09/2017.
//

import Foundation

struct Race {
    let date: Date
    let lapTimes: [LapTime]
    
    var bestTime: LapTime? {
        return lapTimes.min()
    }
}
