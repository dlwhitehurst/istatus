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

    func successCheck(monitor: Monitor) {
        let url = URL(string: monitor.url!)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            print("Success here ...")
        }
        task.resume()
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

            // Test Button
            Button("Test") {
                updateMonitorGreen(monitor: monitor)
                //successCheck(monitor: monitor)
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

