//
//  DBManager.swift
//  MovieList
//
//  Created by Shehroz Arif on 11/09/2023.
//

import Foundation
import CoreData

class DBManager {
    
    static let shared = DBManager()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieList")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
