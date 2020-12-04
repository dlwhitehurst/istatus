//
//  HostTasksView.swift
//  istatus
//
//  Created by David Whitehurst on 12/3/20.
//

import SwiftUI
import CoreData

struct HostTasksView {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: HostTask.entity(), sortDescriptors:
                    [NSSortDescriptor(keyPath: \HostTask.date, ascending: true)])
    var tasks: FetchedResults<HostTask>
}

extension HostTasksView: View {
    var body: some View {
        List {
            ForEach(tasks, id: \.self) { (task: HostTask) in
                HStack(spacing: 20) {
                    Text(task.hostname!)
                    Text(task.task!)
                }
            }
        }
    }
}

struct HostTasksView_Previews: PreviewProvider {
    static var previews: some View {
        HostTasksView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
