//
//  CalendarView.swift
//  FocusTimer
//
//  Created by Robert P on 04.03.2023.
//

import SwiftUI

struct CalendarView: View {
    
    @FetchRequest(fetchRequest: FocusRecord.lastYearRecords) var records: FetchedResults<FocusRecord>
    
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
                        .fill(fillCallendar(item))
                        .frame(width: 3, height: 3)
                }
            }
        }
    }
    
    private func fillCallendar(_ item: Int) -> some ShapeStyle {
        if !records.filter({ $0.date!.index == item }).isEmpty {
            return Color.orange.gradient.opacity(0.85)
        } else {
            return Color.gray.gradient.opacity(0.1)
            
        }
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
