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
                Button("05:00") {
                    model.minutesRemaining = 1.0
                }
                Button("25:00") {
                    model.minutesRemaining = 25.0
                }
                Button("50:00") {
                    model.minutesRemaining = 50.0
                }
            }.disabled(model.state == .active)
            
            Text(model.timerString)
                .font(.system(size: 60, weight: .light, design: .rounded))
                .monospacedDigit()
                .frame(height: 70)
            
            HStack {
                Button {
                    model.start()
                } label: {
                    Text(model.buttonTitle)
                        .frame(width: 60)
                }

                Button {
                    model.reset()
                } label: {
                    Text("Reset")
                        .frame(width: 60)
                }
            }
            .controlSize(.large)
            
            ZStack(alignment: .bottom) {
                Text("Focus Timer")
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(.secondary)
                HStack {
                    Spacer()
                    Button("Quit") {
                        NSApplication.shared.terminate(nil)
                    }
                }
            }
        }
//        .frame(width: 350, height: 200)
        .padding()
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
