//
//  Race.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 01/09/2017.
//

import Foundation

struct Race: Codable {
    let date: Date
    let name: String?
    let lapTimes: [LapTime]
    
    var bestTime: LapTime? {
        return lapTimes.min()
    }
    
    var averageTime: LapTime? {
        return lapTimes.average()
    }
}

extension Race {
    init(date: Date, lapTimes: [LapTime]) {
        self.init(date: date, name: nil, lapTimes: lapTimes)
    }
}
