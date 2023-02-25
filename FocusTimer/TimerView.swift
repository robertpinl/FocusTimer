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
                .font(.title)
                .monospacedDigit()
                .onTapGesture {
                    model.start(min: 25)
                }
            
            
            HStack {
                Button("Start") {
                    model.start()
                }
            }
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
        .frame(width: 400, height: 200)
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

//struct CustomButton: PrimitiveButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 10).fill(color))
//            .onTapGesture { configuration.trigger() }
//    }
//}
