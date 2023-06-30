//
//  ContentView.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI

struct TimerView: View {
    
    @FetchRequest(fetchRequest: FocusRecord.lastYearRecords) var records: FetchedResults<FocusRecord>
    
    @StateObject var model = TimerModel()
    @State private var showCalendar = false
    
    var body: some View {
        VStack {
            Text("Focus Timer")
                .font(.caption)
                .foregroundColor(.secondary)
                .offset(y:-5)
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
                .frame(height: 80)
            
            HStack {
                Button {
                    model.start()
                } label: {
                    Text(model.buttonTitle)
                        .frame(width: 160)
                }
                
            }
            .controlSize(.large)
            
            Button("Reset") {
                model.resetTimer()
            }
            .buttonStyle(.plain)
            .foregroundColor(.secondary)
            .padding(.top, 5)
            
            if showCalendar {
                CalendarView()
                    .offset(y:6)
                    .zIndex(1)
            }
            
            HStack {
                Button("Calendar") {
                    withAnimation {
                        showCalendar.toggle()
                    }
                }
                .buttonStyle(.plain)
                .controlSize(.small)
                .foregroundColor(.secondary)
                
                Spacer()
                
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.plain)
                .controlSize(.small)
                .foregroundColor(.secondary)
            }
            .offset(y: 10)
            
        }
        .onReceive(model.$timer) { _ in
            model.update()
        }
        .zIndex(2)
        .frame(width: 200)
        .padding()
        .background(Material.ultraThick)

        .onAppear {
            NotificationManager.requestPermission()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
