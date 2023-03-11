//
//  FocusRecord+Ext.swift
//  FocusTimer
//
//  Created by Robert P on 09.03.2023.
//

import Foundation
import CoreData

extension FocusRecord {
    static var lastYearRecords: NSFetchRequest<FocusRecord> = {
        let request: NSFetchRequest<FocusRecord> = FocusRecord.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FocusRecord.date, ascending: true)]
        request.predicate = NSPredicate(format: "%K >= %@ && %K <= %@", "date", Date().startOfYear() as NSDate, "date", Date().endOfYear() as NSDate)
        return request }()
}

extension Date {
    func startOfYear() -> Date {
        var components = Calendar.current.dateComponents([.year], from: self)
        components.month = 1
        let year: Date = Calendar.current.date(from: components)!
        let result = Calendar.current.date(byAdding: DateComponents(day: +1), to: year)!
        return Calendar.current.startOfDay(for: result)
    }
    
    func endOfYear() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 12, day: -1), to: self.startOfYear())!
    }
    
    var index: Int {
        return Calendar.current.ordinality(of: .day, in: .year, for: self)!
    }
}
