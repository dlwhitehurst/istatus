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
            .tabItem { Label("Dashboard",
                             systemImage: "square.grid.3x3.fill")
            }
            MonitorsView()
            .tabItem { Label("Monitors",
                             systemImage: "tray.full")
            }
            MonitorCreateView()
            .tabItem { Label("Create",
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
