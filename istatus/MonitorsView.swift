//
//  MonitorsView.swift
//  istatus
//
//  Created by David Whitehurst on 12/3/20.
//

import SwiftUI
import CoreData

struct MonitorsView {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Monitor.entity(), sortDescriptors:
                    [NSSortDescriptor(keyPath: \Monitor.date, ascending: true)])
    var monitors: FetchedResults<Monitor>
}

extension MonitorsView {
    func remove(_ indexSet: IndexSet) {
        // remove all monitors
        indexSet.map { monitors[$0] }.forEach(viewContext.delete)

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

extension MonitorsView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(monitors, id: \.self) { (monitor: Monitor) in
                    NavigationLink(destination:
                                    MonitorDetailView(monitor: monitor)
                                    .navigationBarTitle(Text(monitor.hostname!))){
                        //HStack {
                            Text(monitor.hostname!)
                            //Text(monitor.task!)
                        //}
                    }
                }
                .onDelete(perform: remove)
            }
            .navigationBarTitle("Monitors")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct MonitorsView_Previews: PreviewProvider {
    static var previews: some View {
        MonitorsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
