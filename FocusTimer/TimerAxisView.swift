//
//  TimerAxisView.swift
//  FocusTimer
//
//  Created by Robert P on 25.02.2023.
//

import SwiftUI

struct TimerAxisView: View {
    
    let seconds: Int
    
    var body: some View {
        GeometryReader { geo in
            
            let size = geo.size
            
            HStack {
                ForEach(0..<60) { index in
                    Capsule()
                        .fill(.gray.opacity(0.25))
                        .frame(width: 4, height: index % 15 == 0 ? 40 : 20)
                        .offset(x: (size.width - 40) / 2)
                }
            }
        }
    }
}

struct TimerAxisView_Previews: PreviewProvider {
    static var previews: some View {
        TimerAxisView(seconds: 60)
    }
}
