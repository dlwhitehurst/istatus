//
//  HostTaskCreateView.swift
//  istatus
//
//  Created by David Whitehurst on 12/2/20.
//

import SwiftUI

struct HostTaskCreateView {
    @StateObject private var support = HostTaskCreateViewSupport()
    @ObservedObject var hostTasks = HostTasks()
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
                    let task: HostTask = HostTask(
                        proto: support.proto,
                        hostname: support.hostname,
                        port: support.port,
                        path: support.path,
                        task: "http2xx")

                    // add to collection
                    hostTasks.add(task)
                    
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
