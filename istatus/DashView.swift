//
//  DashView.swift
//  istatus
//
//  Created by David Whitehurst on 12/3/20.
//

import SwiftUI

struct DashView {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Monitor.entity(), sortDescriptors:
                    [NSSortDescriptor(keyPath: \Monitor.date, ascending: true)])
    var monitors: FetchedResults<Monitor>
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false

}

extension DashView {
    
}

extension DashView: View {
    var body: some View {
        VStack {
            Text("iStatus Monitor Events")
            .font(.largeTitle)
            .padding()
/*
            GridStack(rows: 4, columns: 4) { row, col in
                if (row == 2 && col == 2) {
                    StatusButtonRed()
                } else {
                StatusButtonGreen()
                }
            }
*/
            HStack {
                ForEach(monitors, id: \.self) { monitor in
                    if monitor.status {
                        Button(action: {
                            self.showingAlert1 = true
                        }) {
                            VStack {
                                Text(monitor.hostname!)
                                    .padding(.top)
                                    .padding(.horizontal, 10)
                                    .font(.title)
                                Text(monitor.task!)
                                    .font(.caption)
                                    .padding(.bottom)
                             }
                             .background(Color.green)
                             .foregroundColor(Color.white)
                        }
                        .cornerRadius(20)
                        .alert(isPresented: $showingAlert1) {
                        Alert(title: Text("Operation Detail"), message:
                                Text("Success: Resource returns 200...2xx status"), dismissButton: .default(Text("Cancel")))
                        }
                    } else {
                        Button(action: {
                            self.showingAlert2 = true
                        }) {
                            VStack {
                                Text(monitor.hostname!)                                  .padding(.top)
                                    .padding(.horizontal, 10)
                                    .font(.title)
                                Text(monitor.task!)
                                    .font(.caption)
                                    .padding(.bottom)
                             }
                             .background(Color.red)
                             .foregroundColor(Color.white)
                        }
                        .cornerRadius(20)
                        .alert(isPresented: $showingAlert2) {
                        Alert(title: Text("Operation Detail"), message:
                                Text("Failure: Resource unavailable or not returning 200...2xx"), dismissButton: .default(Text("Cancel")))
                        }
                    }
                }
            }
            .padding(.bottom)
            
            Button(action: {
                Runner(monitors: monitors, viewContext: viewContext).run()
            }) {
                Text("Refresh")
            }
            .padding()
            
            Spacer()
        }
    }
}

struct DashView_Previews: PreviewProvider {
    static var previews: some View {
        DashView()
    }
}
