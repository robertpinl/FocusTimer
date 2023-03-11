//
//  ContentView.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI

struct TimerView: View {
    
    @FetchRequest(fetchRequest: FocusRecord.lastYearRecords) var records: FetchedResults<FocusRecord>
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var persistenceController: PersistenceController
    
    @StateObject var model = TimerModel()
    @State private var showCalendar = false
    
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
                
                if showCalendar {
                    CalendarView()
                        .offset(y:6)
                }
                
                ZStack(alignment: .bottom) {
                    Text("Focus Timer")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.secondary)
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
                }
                .offset(y: 10)
            }
            .frame(width: 200)
            .padding()
            .onReceive(model.timer) { _ in
                model.update()
            }
            .onAppear {
                NotificationManager.requestPermission()
//                saveDummyRecord()
                print(Date().startOfYear(), Date().endOfYear())
            }
    }
    
    private func saveRecord() {
        let newRecord = FocusRecord(context: viewContext)
        newRecord.id = UUID().uuidString
        newRecord.date = Date()
        persistenceController.save()
    }
    
    func saveDummyRecord() {
        records.map { print($0.date!) }
        print(records.count)
        
//        for i in (1...10) {
//            let newRecord = FocusRecord(context: viewContext)
//            newRecord.id = UUID().uuidString
//
//            let currentDate = Date()
//            var dateComponent = DateComponents()
//            dateComponent.month = 3
//            dateComponent.day = i * 2
//            let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
//
//            newRecord.date = futureDate
//            persistenceController.save()
//        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
