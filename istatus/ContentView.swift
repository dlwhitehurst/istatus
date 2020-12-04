//
//  ContentView.swift
//  istatus
//
//  Created by David Whitehurst on 12/2/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            DashView()
            .tabItem { Label("Dashboards",
                             systemImage: "rectangle.stack.fill.badge.person.crop")
            }
            HostTasksView()
            .tabItem { Label("Tasks",
                             systemImage: "tray.full")
            }
            HostTaskCreateView()
            .tabItem { Label("Setup",
                                 systemImage: "tray.and.arrow.down")
            }
            VpnView()
            .tabItem { Label("VPN",
                                 systemImage: "network")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
