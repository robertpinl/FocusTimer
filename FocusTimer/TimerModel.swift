//
//  TimerModel.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import Foundation

final class TimerModel: ObservableObject {
    
    @Published var isActive = false
    @Published var isPaused = false
    @Published var ring = false
    @Published var timerString = "25:00"
    @Published var minutesRemaining = 25.0 {
        didSet {
            self.timerString = "\(Int(minutesRemaining)):00"
        }
    }
    
    private var initialTime = 25
    private var endDate = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func start() {
        self.initialTime = Int(minutesRemaining)
        self.endDate = Date()
        self.isActive = true
        self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutesRemaining), to: endDate)!
    }
    
    func pause() {
        if !isPaused {
            
        }
    }
    
    func reset() {
        self.minutesRemaining = Double(initialTime)
        self.isActive = false
        self.timerString = "\(Int(minutesRemaining)):00"
    }
    
    func update(){
        guard isActive else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            self.isActive = false
            self.timerString = "0:00"
            self.ring = true
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        self.minutesRemaining = Double(minutes)
        self.timerString = String(format:"%d:%02d", minutes, seconds)
    }
}
