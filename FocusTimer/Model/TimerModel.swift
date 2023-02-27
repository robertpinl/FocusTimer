//
//  TimerModel.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI

final class TimerModel: ObservableObject {
    
    enum TimerState {
        case active, paused, reseted
    }
        
    @Published var state: TimerState = .reseted
    @Published var ring = false
    @Published var timerString = "25:00"
    @Published var minutesRemaining = 25.0 {
        didSet {
            timerString = minutesRemaining > 5 ? "\(Int(minutesRemaining)):00" : "0\(Int(minutesRemaining)):00"
        }
    }
    
    private let audioPlayer = AudioPlayer()
    
    private var initialTime = 25
    private var endDate = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var buttonTitle: String {
        switch state {
        case .active:
            return "Pause"
        case .paused:
            return "Resume"
        case .reseted:
            return "Start"
        }
    }
    
    func start() {
        if state != .active {
            state = .active
            initialTime = Int(minutesRemaining)
            endDate = Date()
            endDate = Calendar.current.date(byAdding: .minute, value: Int(minutesRemaining), to: endDate)!
        } else if state == .active {
            state = .paused
            
        }
    }
    
    
    
    private func pause() {
//        if !isPaused {
            
//        }
    }
    
    func reset() {
        minutesRemaining = Double(initialTime)
        state = .reseted
        timerString = minutesRemaining > 5 ? "\(Int(minutesRemaining)):00" : "0\(Int(minutesRemaining)):00"
    }
    
    func update(){
        guard state == .active else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            state = .reseted
            timerString = "00:00"
            audioPlayer.playSound()
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        minutesRemaining = Double(minutes)
        timerString = String(format:"%02d:%02d", minutes, seconds)
    }
}
