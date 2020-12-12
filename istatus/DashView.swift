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
                            print("under construction")
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

                    } else {
                        Button(action: {
                            print("under construction")
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

                    }

                }
            }
            .padding(.bottom)
            
            Button(action: {
                print("Hello")
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
