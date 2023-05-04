//
//  FocusTimerApp.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI
import TelemetryClient

@main
struct FocusTimerApp: App {
    
    @StateObject var persistenceController = PersistenceController()
    
    init() {
        let configuration = TelemetryManagerConfiguration(appID: valueForAppId())
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send("appLaunchedRegularly")
    }
    
    var body: some Scene {
        MenuBarExtra("FocusTimer", image: "icon") {
            TimerView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.menuBarExtraStyle(.window)
    }
}
