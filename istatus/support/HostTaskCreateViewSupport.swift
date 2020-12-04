//
//  HostTaskCreateViewSupport.swift
//  istatus
//
//  Created by David Whitehurst on 12/2/20.
//

import SwiftUI

class HostTaskCreateViewSupport: ObservableObject {

    // textfield entry
    @Published var proto: String =    ""
    @Published var hostname: String = ""
    @Published var port: String =     ""
    @Published var path: String =     ""
    @Published var url: String =      ""
   
    // button enable/disable
    @Published var done: Bool =   true
    @Published var add: Bool =    false

}

extension HostTaskCreateViewSupport {
    
    var protoPrompt: String {
        "Protocol"
    }

    var hostPrompt: String {
        "Host IP or DNS"
    }

    var portPrompt: String {
        "Port"
    }

    var pathPrompt: String {
        "Path"
    }
}
