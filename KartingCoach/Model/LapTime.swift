//
//  LapTime.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 01/09/2017.
//

import Foundation

struct LapTime {
    static var zero: LapTime { return LapTime(duration: 0) }
    
    let minutes: Int
    let seconds: Int
    let miliseconds: Int
    
    var duration: Int {
        return miliseconds + seconds * 1000 + minutes * 60 * 1000
    }
    
    // MARK: - Initializers
    
    /**
     * Initialize new lap time
     *
     * - parameter duration: Duration of lap time in miliseconds
     */
    init(duration: Int) {
        assert(duration >= 0, "Duration has to be greater than or equal to 0")
        
        minutes = duration / 1000 / 60
        seconds = duration / 1000 % 60
        miliseconds = duration % 1000
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
    static func < (lhs: LapTime, rhs: LapTime) -> Bool {
        return lhs.duration < rhs.duration
    }
    
    static func == (lhs: LapTime, rhs: LapTime) -> Bool {
        return lhs.duration == rhs.duration
    }
}

func + (lhs: LapTime, rhs: LapTime) -> LapTime {
    return LapTime(duration: lhs.duration + rhs.duration)
}

func / (lhs: LapTime, rhs: Int) -> LapTime {
    return LapTime(duration: lhs.duration / rhs)
}

extension Collection where Iterator.Element == LapTime {
    func average() -> Iterator.Element? {
        if isEmpty { return nil }
        return reduce(.zero, +) / Int(count)
    }
}
