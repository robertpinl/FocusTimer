//
//  AudioPlayer.swift
//  FocusTimer
//
//  Created by Robert P on 27.02.2023.
//

import Foundation
import AVKit

final class AudioPlayer {
    enum SoundType {
        case start, ring
    }
    
    private var audioPlayer: AVAudioPlayer!
    
    func playSound(sound: SoundType) {
        
        let audioFile: URL?
        
        switch sound {
        case .ring:
            audioFile = Bundle.main.url(forResource: "AlarmRing", withExtension: "wav")
        case .start:
            audioFile = Bundle.main.url(forResource: "Start", withExtension: "wav")
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile!)
            audioPlayer.play()
        } catch let error {
            print("Cannot play sound. \(error)")
        }
    }
}
