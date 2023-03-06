//
//  CalendarView.swift
//  FocusTimer
//
//  Created by Robert P on 04.03.2023.
//

import SwiftUI

struct CalendarView: View {
    
    let items = 1...364
    
    let rows = [
        GridItem(.fixed(3), spacing: 1),
        GridItem(.fixed(3), spacing: 1),
        GridItem(.fixed(3), spacing: 1),
        GridItem(.fixed(3), spacing: 1),
        GridItem(.fixed(3), spacing: 1),
        GridItem(.fixed(3), spacing: 1),
        GridItem(.fixed(3), spacing: 1)
    ]
    
    var body: some View {
        VStack {
            LazyHGrid(rows: rows, alignment: .center, spacing: 1) {
                ForEach(items, id: \.self) { item in
                    Rectangle()
                        .fill(Color.orange.gradient.opacity(0.8))
                        .frame(width: 3, height: 3)
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
