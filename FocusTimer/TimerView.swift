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
            Text(model.timerString)
                .font(.system(size: 60, weight: .light, design: .rounded))
                .monospacedDigit()
            
            HStack {
                Button(model.buttonTitle) {
                    model.start()
//                    model.playSound()
                }
                .buttonStyle(StartStopButton())
            }
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
//        .frame(width: 400, height: 200)
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
