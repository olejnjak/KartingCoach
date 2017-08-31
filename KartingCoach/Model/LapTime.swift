//
//  LapTime.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 01/09/2017.
//

import Foundation

struct LapTime {
    let minutes: Int
    let seconds: Int
    let miliseconds: Int
    
    private var duration: Int {
        return miliseconds + seconds * 1000 + minutes * 60 * 1000
    }
}

extension LapTime: CustomStringConvertible {
    var description: String {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let secondsAndMiliseconds = String(seconds) + decimalSeparator + String(miliseconds)
        return minutes > 0 ? String(minutes) + ":" + secondsAndMiliseconds : secondsAndMiliseconds
    }
}

extension LapTime: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(self)"
    }
}

extension LapTime: Comparable {
    static func<(lhs: LapTime, rhs: LapTime) -> Bool {
        return lhs.duration < rhs.duration
    }
    
    static func==(lhs: LapTime, rhs: LapTime) -> Bool {
        return lhs.duration == rhs.duration
    }
}
