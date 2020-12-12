//
//  PersistenceController.swift
//  istatus
//
//  Created by David Whitehurst on 12/3/20.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<4 {
            let newMonitor = Monitor(context: viewContext)
            newMonitor.date = Date()
            newMonitor.proto = "http"
            newMonitor.hostname = "localhost"
            newMonitor.port = "8080"
            newMonitor.path = "wordpress"
            newMonitor.task = "http2xx"
        }
        do {
            try viewContext.save()
        } catch {
            // TODO replace with view handling
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "istatus")
        
        // DLW added
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // TODO replace with view handling
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
