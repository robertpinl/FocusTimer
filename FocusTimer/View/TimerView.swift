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
            HStack(spacing: 10) {
                Button("05:00") {
                    model.minutesRemaining = 5.0
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
                .frame(height: 75)
            
            HStack {
                Button {
                    model.start()
                } label: {
                    Text(model.buttonTitle)
                        .frame(width: 160)
                }

//                Button {
//                    model.reset()
//                } label: {
//                    Text("Reset")
//                        .frame(width: 70)
//                }
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
//                    .offset(x: 85, y: 12)
                    .buttonStyle(.plain)
                    .controlSize(.small)
                    .foregroundColor(.secondary)
                }
            }
            .offset(y: 10)
        }
        .padding()
        .frame(width: 210)
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
