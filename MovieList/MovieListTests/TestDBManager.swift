//
//  TestDBManager.swift
//  MovieListTests
//
//  Created by Shehroz Arif on 11/09/2023.
//

import CoreData

class TestDBManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieList")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType // Use in-memory store for testing
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
