//
//  HostTaskCreateView.swift
//  istatus
//
//  Created by David Whitehurst on 12/2/20.
//

import SwiftUI

struct HostTaskCreateView {
    @StateObject private var support = HostTaskCreateViewSupport()
    //@ObservedObject var hostTasks = HostTasks()
    @Environment(\.managedObjectContext) private var viewContext
}

extension HostTaskCreateView {
    func build() -> String {
        return support.proto + "://" + support.hostname + ":" + support.port + "/" + support.path
    }
}

extension HostTaskCreateView: View {
    var body: some View {
        VStack(spacing:0) {
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
            //CheckTaskPicker()
               // .padding(.top)
            HStack {
                Button("Add"){
                
                    // create a HostTask
                    let task = HostTask(context: viewContext)
                    task.date = Date()
                    task.proto = support.proto
                    task.hostname = support.hostname
                    task.port = support.port
                    task.path = support.path
                    task.task = "http2xx"

                    // add to collection
                    //hostTasks.add(task)
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }

                    
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

struct HostTaskCreateView_Previews: PreviewProvider {
    static var previews: some View {
        HostTaskCreateView()
    }
}
