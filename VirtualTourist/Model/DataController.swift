//
//  DataController.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 19/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import Foundation
import CoreData
// MARK: - Core Data stack
class DataController {
    // make it shared
    static let shared = DataController()

    let persistentContainer: NSPersistentContainer
    var backgroundContext:NSManagedObjectContext!
    // viewContext
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    // Mark: initilize
    private init() {
        persistentContainer = NSPersistentContainer(name: "VirtualTourist")
    }
    // Mark: load
    func load(completion: (() -> Void)? = nil) {
    
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.backgroundContext = self.persistentContainer.newBackgroundContext()
            // auto save
            self.autoSaveViewContext()
            // enable automatic merging.
            self.viewContext.automaticallyMergesChangesFromParent = true
            self.backgroundContext.automaticallyMergesChangesFromParent = true
            self.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
            self.backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            completion?()
        }
    
    }
}

// MARK: - Autosaving
extension DataController {
    private func autoSaveViewContext(interval:TimeInterval = 30) {
        let timeInterval = interval > 0 ? interval : 30
        if interval <= 0 {
            // just informing the developer that something wrong has happened
            print("time interval should be greater than 0, will use the default time interval")
        }
        
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            self.autoSaveViewContext(interval: timeInterval)
        }
    }
}
