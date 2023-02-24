//
//  FocusTimerApp.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI

@main
struct FocusTimerApp: App {
    var body: some Scene {
        MenuBarExtra("FocusTimer", systemImage: "timer") {
            ContentView()
        }.menuBarExtraStyle(.window)
    }
}
