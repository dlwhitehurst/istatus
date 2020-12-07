//
//  DashView.swift
//  istatus
//
//  Created by David Whitehurst on 12/3/20.
//

import SwiftUI

struct MonitorEvent : Hashable{
    let date = Date()
    let status: Bool
    let task: String
    let uri: String
    let host: String
}

struct DashView {
    var events: Array<MonitorEvent> = []
    init() {
        // create MonitorEvent
        let event1: MonitorEvent = MonitorEvent(status: true, task: "http-status", uri: "http://localhost:8080/admin/login", host: "localhost")
        let event2: MonitorEvent = MonitorEvent(status: true, task: "http-status", uri: "http://localhost:8081/health", host: "192.168.1.3")
        let event3: MonitorEvent = MonitorEvent(status: false, task: "http-status", uri: "http://localhost:8080/contacts", host: "127.0.0.1")

        events.append(event1)
        events.append(event2)
        events.append(event3)
    }
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
                ForEach(events, id: \.self) { event in
                    if event.status {
                        Button(action: {
                            print("under construction")
                        }) {
                            VStack {
                                Text(event.host)
                                    .padding(.top)
                                    .padding(.horizontal, 10)
                                    .font(.title)
                                Text(event.task)
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
                                Text(event.host)
                                    .padding(.top)
                                    .padding(.horizontal, 10)
                                    .font(.title)
                                Text(event.task)
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
            
            Button(action: {}) {
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
