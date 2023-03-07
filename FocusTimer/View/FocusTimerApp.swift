//
//  FocusTimerApp.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI

@main
struct FocusTimerApp: App {
    
    @StateObject var persistenceController = PersistenceController()
    
    var body: some Scene {
        MenuBarExtra("FocusTimer", image: "icon") {
            TimerView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(persistenceController)
        }.menuBarExtraStyle(.window)
    }
}
