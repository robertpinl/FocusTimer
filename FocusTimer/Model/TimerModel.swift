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
    private let notification = NotificationManager()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var initialTime = 25
    private var endDate = Date()
    
    
    var buttonTitle: String {
        switch state {
        case .active:
            return "Give Up!"
        case .paused:
            fatalError("This should never happen - now.")
//            return "Resume"
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
        case .active:
            state = .reseted
            reset()
        case .paused:
            fatalError("This should never happen - now.")
            //            state = .active
            //            endDate = Date()
            //            endDate = Calendar.current.date(byAdding: .minute, value: Int(minutesRemaining), to: endDate)!
        }
    }
    
    func reset() {
        state = .reseted
        minutesRemaining = Double(initialTime)
    }
    
    func update(completion: () -> Void){
        guard state == .active else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            state = .reseted
            timerString = "00:00"
            audioPlayer.playSound(sound: .ring)
            notification.showTimerWentOff()
            completion()
            reset()
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
