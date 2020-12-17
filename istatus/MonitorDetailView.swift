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

    private func updateMonitorYellow(monitor: Monitor) {
        let newStatus = Status.yellow //true
        viewContext.performAndWait {
            monitor.status = newStatus.rawValue
            try? viewContext.save()
        }
    }

    private func updateMonitorGreen(monitor: Monitor) {
        let newStatus = Status.green //true
        viewContext.performAndWait {
            monitor.status = newStatus.rawValue
            try? viewContext.save()
        }
    }

    private func updateMonitorRed(monitor: Monitor) {
        let newStatus = Status.red //false
        viewContext.performAndWait {
            monitor.status = newStatus.rawValue
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
                DetailTextDisplay(value: monitor.status!)
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
                Button("Set Yellow") {
                    updateMonitorYellow(monitor: monitor)
                }
                .padding()
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

