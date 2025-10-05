//
//  CoreDataStack.swift
//  Books
//
//  Created by Eduardo Bertol on 02/10/25.
//

import Foundation
import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack(modelName: "BooksModel") // ajuste se o seu .xcdatamodeld tiver outro nome
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
    
    private init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        
        if let desc = persistentContainer.persistentStoreDescriptions.first {
            desc.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
            desc.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
        }
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data store: \(error)")
            }
            
            self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            self.persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext() {
        let context = viewContext
        guard context.hasChanges else { return }
        do { try context.save() } catch {
            context.rollback()
            print("CoreData save error: \(error)")
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
}

