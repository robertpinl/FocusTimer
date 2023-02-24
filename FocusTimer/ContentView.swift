//
//  ContentView.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var timeRemaining = 25
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(timeRemaining)")
                .font(.title)
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
