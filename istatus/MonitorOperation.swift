//
//  MonitorOperation.swift
//  istatus
//
//  Created by David Whitehurst on 12/12/20.
//

import Foundation
import SwiftUI
import CoreData

final class MonitorOperation: AsyncOperation {
    //@Environment(\.managedObjectContext) private var viewContext

    private let monitor: Monitor
    private let viewContext: NSManagedObjectContext

    public var monitorTask: URLSessionTask?

    init(monitor: Monitor, viewContext: NSManagedObjectContext) {
        self.monitor = monitor
        self.viewContext = viewContext
    }

    private func updateMonitorGreen(monitor: Monitor, statusMsg: String) {
        let newStatus = true
        viewContext.performAndWait {
            monitor.status = newStatus
            monitor.statusmsg = statusMsg
            try? viewContext.save()
        }
    }

    private func updateMonitorRed(monitor: Monitor, statusMsg: String) {
        let newStatus = false
        viewContext.performAndWait {
            monitor.status = newStatus
            monitor.statusmsg = statusMsg
            try? viewContext.save()
        }
    }

    override func main() {
        let url = URL(string: monitor.url!)!
        monitorTask = URLSession.shared.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                self.updateMonitorRed(monitor: self.monitor, statusMsg: "Client Error: \(error!.localizedDescription)")
                return
            }
            // was guard let
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                self.updateMonitorRed(monitor: self.monitor, statusMsg: "Server Error: was not status 200...299")
                return
            }
            //print("before finish")
            self.finish()
            self.updateMonitorGreen(monitor: self.monitor, statusMsg: "Success! Resource returned 2xx status!")
            print("monitor operation finished")
        }
        monitorTask!.resume()
    }

    override func cancel() {
        monitorTask?.cancel()
        super.cancel()
    }
}
