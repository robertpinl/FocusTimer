//
//  CalendarView.swift
//  FocusTimer
//
//  Created by Robert P on 04.03.2023.
//

import SwiftUI

struct CalendarView: View {
    
    @FetchRequest(fetchRequest: FocusRecord.lastYearRecords) var records: FetchedResults<FocusRecord>
    @FetchRequest(fetchRequest: FocusRecord.allRecords) var allrecords: FetchedResults<FocusRecord>
    
    let items = 1...364
    
    let rows = Array(repeating: GridItem(.fixed(3), spacing: 1), count: 7)
    
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
        let filtered = records.filter({ $0.date!.index == item })
        
        if filtered.isEmpty {
            return Color.gray.gradient.opacity(0.1)
        } else if filtered.count == 1  {
            return Color.orange.gradient.opacity(0.75)
        } else if filtered.count == 2 {
            return Color.orange.gradient.opacity(0.85)
        } else if filtered.count == 3 {
            return Color.orange.gradient.opacity(0.9)
        } else {
            return Color.orange.gradient.opacity(0.95)
        }
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
