//
//  PersistenceController.swift
//  FocusTimer
//
//  Created by Robert P on 05.03.2023.
//

import Foundation
import CoreData

final class PersistenceController: NSObject, ObservableObject {
        
    let container: NSPersistentCloudKitContainer
        
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "FocusTimer")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

extension PersistenceController {
    func save() {
        let viewContext = container.viewContext
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                viewContext.rollback()
                print("❌ Failed to save data: \(error)")
            }
        }
    }
    
}

extension PersistenceController {
    func deleteAll() {
          let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = FocusRecord.fetchRequest()
          let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
          _ = try? container.viewContext.execute(batchDeleteRequest1)
    }
}
