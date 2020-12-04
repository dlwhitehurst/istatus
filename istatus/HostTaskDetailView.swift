//
//  HostTaskDetailView.swift
//  InfraCheck
//
//  Created by David Whitehurst on 11/28/20.
//

import SwiftUI

struct HostTaskDetailView {
    let task: HostTask
}

extension HostTaskDetailView: View {
    var body: some View {
        //Text("HostTaskDetailView")
        
        VStack {
            HStack(alignment: .center) {
                LabelTextDisplay(value: "Protocol")
                DetailTextDisplay(value: task.proto!)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                LabelTextDisplay(value: "Host")
                DetailTextDisplay(value: task.hostname!)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                LabelTextDisplay(value: "Port")
                DetailTextDisplay(value: task.port!)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                LabelTextDisplay(value: "Path")
                DetailTextDisplay(value: task.path!)
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                LabelTextDisplay(value: "Task")
                DetailTextDisplay(value: task.task!)
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                LabelTextDisplay(value: "Status")
                DetailTextDisplay(value: "abc")
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

struct HostTaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HostTaskDetailView(task: HostTask()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

