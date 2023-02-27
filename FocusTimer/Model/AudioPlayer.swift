//
//  AudioPlayer.swift
//  FocusTimer
//
//  Created by Robert P on 27.02.2023.
//

import Foundation
import AVKit

final class AudioPlayer {
    
    private var audioPlayer: AVAudioPlayer!
    
    func playSound() {
        guard let audioFile = Bundle.main.url(forResource: "AlarmRing", withExtension: "wav") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
            audioPlayer.play()
        } catch let error {
            print("Cannot play sound. \(error)")
        }
    }
}
