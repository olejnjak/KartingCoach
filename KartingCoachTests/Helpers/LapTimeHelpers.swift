//
//  LapTimeHelpers.swift
//  KartingCoachTests
//
//  Created by Jakub Olejník on 01/09/2017.
//

import Foundation
@testable import KartingCoach

extension LapTime {
    static var random: LapTime {
        let duration = UInt.random + 20
        return LapTime(duration: duration)
    }
}
