//
//  ContentView.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI

struct TimerView: View {
    
    @StateObject private var model = TimerModel()
    
    var body: some View {
        VStack {
            HStack {
                Button("5:00") {
                    model.minutesRemaining = 5.0
                }
                Button("25:00") {
                    model.minutesRemaining = 25.0
                }
                Button("50:00") {
                    model.minutesRemaining = 50.0
                }
            }
            
            Text(model.timerString)
                .font(.system(size: 60, weight: .light, design: .rounded))
                .monospacedDigit()
                .frame(height: 65)
            
            HStack {
                Button(model.buttonTitle) {
                    model.start()
//                    model.playSound()
                }
                .buttonStyle(StartStopButton())
            }
            
            Button("Reset") {
                model.reset()
            }
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
//        .frame(width: 350, height: 200)
        .padding(30)
        .padding(.horizontal)
        .onReceive(model.timer) { _ in
            model.update()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
