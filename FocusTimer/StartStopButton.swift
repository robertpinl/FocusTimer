//
//  StartStopButton.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI

//struct StartStopButton: View {
//
//    let action: () -> Void
//
//    var body: some View {
//        Button {
//            action()
//        } label: {
//            Text("Start")
//                .foregroundColor(.white)
//        }
//        .frame(width: 200, height: 50)
//        .background(Color.gray)
//
//    }
//}

//struct StartStopButton_Previews: PreviewProvider {
//    static var previews: some View {
//        StartStopButton()
//    }
//}

struct StartStopButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.title, design: .rounded))
            .padding()
            .frame(width:150, height: 44)
            .background(Color.secondary.cornerRadius(8))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
