//
//  MonitorCreateView.swift
//  istatus
//
//  Created by David Whitehurst on 12/2/20.
//

import SwiftUI

struct MonitorCreateView {
    @StateObject private var support = MonitorCreateViewSupport()
    @Environment(\.managedObjectContext) private var viewContext
    private var tasks = ["http-status", "http-content", "jdbc-connect", "telnet-port", "cron-status", "file-exists"]
    @State var selectedTask = 0

}


extension MonitorCreateView {
    // url builder
    func build() -> String {
        return support.proto + "://" + support.hostname + ":" + support.port + "/" + support.path
    }
    
    // Create and persist a Monitor entity using Core-Data and viewContext
    func createMonitor() {
        let monitor = Monitor(context: viewContext)
        monitor.date = Date()
        monitor.proto = support.proto
        monitor.hostname = support.hostname
        monitor.port = support.port
        monitor.path = support.path
        monitor.task = tasks[selectedTask]
        monitor.url = build()
        monitor.status = false

        // save
        do {
            try viewContext.save()
        } catch {
            // replace with UI error handling (fatalError dev only)
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}

extension MonitorCreateView: View {
    var body: some View {
        VStack(spacing:0) {
            Text("Monitor")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)

            Picker(selection: $selectedTask, label: Text("Please choose a Task")) {
                ForEach(0 ..< tasks.count) {
                    Text(self.tasks[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 600, height: 30)
            .padding(.bottom)

            HStack {
                Text("Protocol")
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                    .padding(.leading)
                TextField(support.protoPrompt, text: $support.proto)
                    .modifier(TextEntryModifier())
            }
            .padding(.top)
            
            HStack {
                Text("Host")
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                    .padding(.leading)
                TextField(support.hostPrompt, text: $support.hostname)
                    .modifier(TextEntryModifier())
            }
            .padding(.top)
            HStack {
                Text("Port")
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                    .padding(.leading)
                TextField(support.portPrompt, text: $support.port)
                    .modifier(TextEntryModifier())
            }
            .padding(.top)
            HStack {
                Text("Path")
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                    .padding(.leading)
                TextField(support.pathPrompt, text: $support.path)
                    .modifier(TextEntryModifier())
            }
            .padding(.vertical)
            HStack {
                Button("Add"){
                    // create monitor and event
                    createMonitor()
                    
                    // create url to also show below
                    support.url = build()
                    
                    // clear the entry textboxes
                    support.proto = ""
                    support.hostname = ""
                    support.port = ""
                    support.path = ""
                
                    support.done = false
                    support.add = true
                }
                .padding()
                .disabled(support.add)
                
                Button("Done") {
                    print("Done")
                    support.done = true
                    support.add = false
                    support.url = ""
                }
                .padding()
                .disabled(support.done)
            }
            .padding(.bottom)
            
            Text(support.url)
            Spacer()
        }
        .padding()
    }
}

struct MonitorCreateView_Previews: PreviewProvider {
    static var previews: some View {
        MonitorCreateView()
    }
}
