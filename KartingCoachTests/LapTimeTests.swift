//
//  KartingCoachTests.swift
//  KartingCoachTests
//
//  Created by Jakub Olejník on 06/08/2017.
//

import XCTest
@testable import KartingCoach

final class LapTimeTests: XCTestCase {
    
    func testDurationInit() {
        let duration = UInt(arc4random()) + 20
        let lapTime = LapTime(duration: duration)
        
        XCTAssertEqual(lapTime.duration, duration)
    }
    
}
