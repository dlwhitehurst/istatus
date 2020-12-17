//
//  Runner.swift
//  istatus
//
//  Created by David Whitehurst on 12/12/20.
//

import Foundation
import SwiftUI
import CoreData

final class Runner {
 
    private let monitors: FetchedResults<Monitor>
    private let viewContext: NSManagedObjectContext

    init(monitors: FetchedResults<Monitor>, viewContext: NSManagedObjectContext) {
        self.monitors = monitors
        self.viewContext = viewContext
    }

    private func updateMonitorYellow(monitor: Monitor) {
        let newStatus = Status.yellow //true
        viewContext.performAndWait {
            monitor.status = newStatus.rawValue
            try? viewContext.save()
        }
    }

    func run() {
        // all to yellow first
        for monitor in monitors {
            updateMonitorYellow(monitor: monitor)
        }
        
        // now thread each network call
        for monitor in monitors {
            MonitorOperation(monitor: monitor, viewContext: viewContext).start()
        }
    }
}
