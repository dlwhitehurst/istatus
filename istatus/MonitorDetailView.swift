//
//  MonitorDetailView.swift
//  InfraCheck
//
//  Created by David Whitehurst on 11/28/20.
//

import SwiftUI

struct MonitorDetailView {
    @Environment(\.managedObjectContext) private var viewContext
    let monitor: Monitor
}

extension MonitorDetailView {

    private func updateMonitorGreen(monitor: Monitor) {
        let newStatus = true
        viewContext.performAndWait {
            monitor.status = newStatus
            try? viewContext.save()
        }
    }

    private func updateMonitorRed(monitor: Monitor) {
        let newStatus = false
        viewContext.performAndWait {
            monitor.status = newStatus
            try? viewContext.save()
        }
    }
}

extension MonitorDetailView: View {
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                LabelTextDisplay(value: "Protocol")
                DetailTextDisplay(value: monitor.proto!)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                LabelTextDisplay(value: "Host")
                DetailTextDisplay(value: monitor.hostname!)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                LabelTextDisplay(value: "Port")
                DetailTextDisplay(value: monitor.port!)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                LabelTextDisplay(value: "Path")
                DetailTextDisplay(value: monitor.path!)
                Spacer()
            }
            .padding(.horizontal)

            HStack {
                LabelTextDisplay(value: "Task")
                DetailTextDisplay(value: monitor.task!)
                Spacer()
            }
            .padding(.horizontal)

            HStack {
                LabelTextDisplay(value: "URL")
                DetailTextDisplay(value: monitor.url!)
                Spacer()
            }
            .padding(.horizontal)

            HStack {
                LabelTextDisplay(value: "Status")
                DetailTextDisplay(value: monitor.status.description)
                Spacer()
            }
            .padding(.horizontal)

            HStack {
                LabelTextDisplay(value: "Status Message")
                DetailTextDisplay(value: monitor.statusmsg ?? "FATAL: Status message is nil")
                Spacer()
            }
            .padding(.horizontal)

            HStack {
                Button("Set Green") {
                    updateMonitorGreen(monitor: monitor)
                }
                .padding()
                Button("Set Red") {
                    updateMonitorRed(monitor: monitor)
                }
                .padding()
                Button("Monitor") {
                    MonitorOperation(monitor: monitor, viewContext: viewContext).start()
                }
                .padding()
            }

            Spacer()
        }
        .padding(.bottom)
     

    }
}

struct MonitorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MonitorDetailView(monitor: Monitor()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

