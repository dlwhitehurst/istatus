//
//  MonitorDetailView.swift
//  InfraCheck
//
//  Created by David Whitehurst on 11/28/20.
//

import SwiftUI

struct MonitorDetailView {
    let monitor: Monitor
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
            
            // Test Button
            Button("Test") {
                print("Test")
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

