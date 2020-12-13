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

    func run() {
        for monitor in monitors {
            MonitorOperation(monitor: monitor, viewContext: viewContext).start()
        }
    }
}
