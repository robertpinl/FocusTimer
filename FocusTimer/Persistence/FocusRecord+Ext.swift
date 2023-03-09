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
//        request.predicate = NSPredicate(format: "(inceptionDate > %@) AND (inceptionDate < %@)", "")
        return request }()
}
