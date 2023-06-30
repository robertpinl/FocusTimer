//
//  TimerModel.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI
import Combine

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
    
    private let persistenceController = PersistenceController.shared
    private let audioPlayer = AudioPlayer()
    private let notification = NotificationManager()
    
    @Published var timer: AnyCancellable?
    private var initialTime = 25
    private var endDate = Date()
    private var pausedTime: TimeInterval = 0
    
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
        switch state {
        case .reseted:
            state = .active
            initialTime = Int(minutesRemaining)
            endDate = Date()
            endDate = Calendar.current.date(byAdding: .minute, value: Int(minutesRemaining), to: endDate)!
            audioPlayer.playSound(sound: .start)
            startTimer()
        case .active:
            state = .paused
            pauseTimer()
        case .paused:
            state = .active
            resumeTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.update()
            }
    }
    
    private func pauseTimer() {
        timer?.cancel()
        let now = Date()
        pausedTime = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
    }
    
    private func resumeTimer() {
        guard let timer = timer else {
            fatalError("TimerModel.resumeTimer >> Error: Timer not initialized")
        }
        endDate = Date().addingTimeInterval(pausedTime)
        startTimer()
    }
    
    func resetTimer() {
        timer?.cancel()
        pausedTime = 0
        state = .reseted
    }
    
    func update() {
        guard state == .active else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            state = .reseted
            timerString = "00:00"
            audioPlayer.playSound(sound: .ring)
            notification.showTimerWentOff()
            saveRecord()
            resetTimer()
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        minutesRemaining = Double(minutes)
        timerString = String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func saveRecord() {
        let newRecord = FocusRecord(context: persistenceController.container.viewContext)
        newRecord.id = UUID().uuidString
        newRecord.date = Date()
        persistenceController.save()
    }
}


