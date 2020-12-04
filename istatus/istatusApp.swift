//
//  istatusApp.swift
//  istatus
//
//  Created by David Whitehurst on 12/2/20.
//

import SwiftUI

@main
struct istatusApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
