//
//  TimerModelTests.swift
//  FocusTimerTests
//
//  Created by Robert P on 02.07.2023.
//

import XCTest
@testable import FocusTimer

class TimerModelTests: XCTestCase {
    var timerModel: TimerModel!
    
    override func setUp() {
        super.setUp()
        timerModel = TimerModel()
    }
    
    override func tearDown() {
        timerModel = nil
        super.tearDown()
    }
    
    func testButtonTitle() {
        // Test when state is reseted
        timerModel.state = .reseted
        XCTAssertEqual(timerModel.buttonTitle, "Start")
        
        // Test when state is active
        timerModel.state = .active
        XCTAssertEqual(timerModel.buttonTitle, "Pause")
        
        // Test when state is paused
        timerModel.state = .paused
        XCTAssertEqual(timerModel.buttonTitle, "Resume")
    }
    
    func testStart() {
        // Test start when state is reseted
        timerModel.state = .reseted
        timerModel.minutesRemaining = 25.0
        timerModel.start()
        XCTAssertEqual(timerModel.state, .active)
        
        // Test start when state is active
        timerModel.state = .active
        timerModel.start()
        XCTAssertEqual(timerModel.state, .paused)
        
        // Test start when state is paused
        timerModel.state = .paused
        timerModel.start()
        XCTAssertEqual(timerModel.state, .active)
    }
    
    func testResetTimer() {
        timerModel.state = .active
        timerModel.resetTimer()
        XCTAssertEqual(timerModel.state, .reseted)
        XCTAssertEqual(timerModel.minutesRemaining, 25.0)
    }
}
