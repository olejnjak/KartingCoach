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
        let duration = Int(arc4random()) + 20
        let lapTime = LapTime(duration: duration)
        
        XCTAssertEqual(lapTime.duration, duration)
    }
 
    func testPlusOperation() {
        let (lt1, lt2) = (LapTime.random, LapTime.random)
        let newLT = lt1 + lt2
        
        XCTAssertEqual(newLT.duration, lt1.duration + lt2.duration)
    }
    
    func testDivideOperation() {
        let lt = LapTime.random
        let div = (Int.random % 20) + 2
        let divided = lt / div
        
        XCTAssertEqual(lt.duration / div, divided.duration)
    }
    
    func testAverageLapTime() {
        let itemCount = (Int.random % 20) + 3
        let items = (0..<itemCount).map { _ in LapTime.random }
        
        let duration = items.reduce(0) { $0 + $1.duration }
        let average = items.reduce(LapTime(duration: 0), +) / itemCount
        
        XCTAssertEqual(average.duration, duration / itemCount)
    }
    
    func testStringInitDuration() {
        let duration = Int(arc4random()) + 20
        let lapTime = LapTime(string: String(duration))!
        
        XCTAssertEqual(lapTime.duration, duration)
    }
    
    func testStringInitLapTime() {
        let duration = 119348
        let correctLapTime = LapTime(duration: duration)
        let durationString = "1:59.348"
        let testLapTime = LapTime(string: durationString)!
        
        XCTAssertEqual(correctLapTime, testLapTime)
    }
}
