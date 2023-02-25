//
//  TimerModel.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import Foundation
import AVFoundation

final class TimerModel: ObservableObject {
    
    enum TimerState {
        case active, paused, reseted
    }
    @Published var state: TimerState = .reseted
    @Published var isPaused = false
    @Published var ring = false
    @Published var timerString = "25:00"
    @Published var minutesRemaining = 1.0 {
        didSet {
            self.timerString = "\(Int(minutesRemaining)):00"
        }
    }
    
    private var initialTime = 1
    private var endDate = Date()
    private var audioPlayer: AVAudioPlayer? = nil
    
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
        self.initialTime = Int(minutesRemaining)
        self.endDate = Date()
        self.state = .active
        self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutesRemaining), to: endDate)!
    }
    
    func pause() {
        if !isPaused {
            
        }
    }
    
    func reset() {
        self.minutesRemaining = Double(initialTime)
        self.state = .reseted
        self.timerString = "\(Int(minutesRemaining)):00"
    }
    
    func update(){
        guard state == .active else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            self.state = .reseted
            self.timerString = "0:00"
            playSound()
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        self.minutesRemaining = Double(minutes)
        self.timerString = String(format:"%02d:%02d", minutes, seconds)
    }
    
    func playSound() {
        guard let audioFile = Bundle.main.path(forResource: "BoxingBell", ofType: "mp3") else { return }
        
        do {
            let soundPlayer: AVAudioPlayer? = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFile))
            guard let player = soundPlayer else { return }
            
            player.play()
            
        } catch let error {
            print("Cannot play sound. \(error)")
        }
    }
}
