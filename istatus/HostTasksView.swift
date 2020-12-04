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

extension HostTasksView {
    func remove(_ indexSet: IndexSet) {
        // remove all tasks
        indexSet.map { tasks[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension HostTasksView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks, id: \.self) { (task: HostTask) in
                    NavigationLink(destination:
                                    HostTaskDetailView(task: task)
                                    .navigationBarTitle(Text(task.hostname!))){
                        HStack {
                            Text(task.hostname!)
                            Text(task.task!)
                        }
                    }
                }
                .onDelete(perform: remove)
            }
            .navigationBarTitle("Host Tasks")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct HostTasksView_Previews: PreviewProvider {
    static var previews: some View {
        HostTasksView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
